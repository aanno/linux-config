# Fedora CoreOS on kvm (virt-manager)

* [SLES libvirt docs](https://documentation.suse.com/de-de/sles/15-SP6/html/SLES-all/cha-libvirt-config-virsh.html) extreme verbose, e.g. PCI and CPU passthrough
* [virtio paravirtualized drivers for network and block devices (disks)](https://wiki.libvirt.org/Virtio.html)

## Setup network bridge (on br0 or on virbr0)

* https://linuxconfig.org/how-to-use-bridged-networking-with-libvirt-and-kvm [1], plain bridge (recommended)
* https://docs.fedoraproject.org/en-US/fedora-server/administration/virtual-routing-bridge/ [2], virtual routing bridge (NAT case)

### virt-manager part

```virsh
net-define virt/default-br0.xml 
net-list --all
net-start bridged-network
net-autostart bridged-network
```

* https://wiki.qemu.org/Documentation/Networking
* https://bbs.archlinux.org/viewtopic.php?id=272246

### host network config stack part

* depends on network config stack, could be { nm, netplan, or (static) stuff }
* (TODO) network bridge is already defined in nm and must only be activated
  + this seems to be the tricky part
  + start `virt-manager` _after_ bridge is up
* netfilter _must_ be disabled (but only for plain bridge?), see [1] for details
* ip forwarding _must_ be enabled (but only for virtual (routing) bridge?), see [2] for details

Sometimes this is helpful:

```bash
sudo ip link add br0 type bridge
sudo ip link set br0 up
sudo ip link set eno1 master br0
ip addr
```

#### Problem: Network is working but DNS not

To test (https://discussion.fedoraproject.org/t/dns-not-resolving-on-fedora-server-39/96087):

```bash
resolvectl --no-pager status
resolvectl --no-pager query example.org
systemctl status systemd-resolved.service
readlink -f /etc/resolv.conf
nslookup example.org
nslookup example.org 8.8.8.8
```

##### No DNS: virtual routing bridge (virbr0) case

Not solved. Work-arounds:

* provide DNS in /etc/resolv.conf (other than 127.0.0.53)
* try to set dns in nm (see https://discussion.fedoraproject.org/t/dns-resolution-broken/67067)

##### No DNS: plain bridge (br0) case

* ensure that VM runs on br0
  + virt-manager -> VM -> Information Icon -> NIC
    - settings should be: Network source -> bridge, Device name -> br0
* it will take a few seconds before ip is displayed on login terminal because of DHCP

#### Links

nm:
* https://unix.stackexchange.com/questions/501260/where-does-network-manager-store-settings

netplan:
* https://askubuntu.com/questions/1412503/setting-up-a-bridge-for-host-and-vm

## virt pools (places were VM images are stored)

* https://serverfault.com/questions/840519/how-to-change-the-default-storage-pool-from-libvirt
* https://ostechnix.com/how-to-change-kvm-libvirt-default-storage-pool-location/

## firewall

With fedora (41) as host system, no firewall configuration change is required (at least for the br0 case)

* https://libvirt.org/firewall.html

## setup CoreOS (on fedora)

```bash
# an alternative would be to use coreos-installer container image
sudo dnf install coreos-installer butane virt-manager virt-install
mkdir -p .local/share/libvirt/images
export STREAM=stable
coreos-installer download -s "${STREAM}" -p qemu -f qcow2.xz --decompress -C ~/.local/share/libvirt/images/
# copy ssh public key to embed in ign file
ln -s ~/.ssh/id_ed25519.pub butane-embedded/
```
