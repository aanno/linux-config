# Fedora CoreOS on kvm (virt-manager)

## Setup network bridge (on br0)

* https://linuxconfig.org/how-to-use-bridged-networking-with-libvirt-and-kvm

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

Sometimes this is helpful:

```bash
sudo ip link add br0 type bridge
sudo ip link set br0 up
sudo ip link set eno1 master br0
ip addr
```

#### Links

nm:
* https://unix.stackexchange.com/questions/501260/where-does-network-manager-store-settings

netplan:
* https://askubuntu.com/questions/1412503/setting-up-a-bridge-for-host-and-vm

## virt pools (places were VM images are stored)

* https://serverfault.com/questions/840519/how-to-change-the-default-storage-pool-from-libvirt
* https://ostechnix.com/how-to-change-kvm-libvirt-default-storage-pool-location/

## setup CoreOS (on fedora)

```bash
# an alternative would be to use coreos-installer container image
sudo dnf install coreos-installer butane virt-manager virt-install
export STREAM=stable
mkdir -p .local/share/libvirt/images
coreos-installer download -s "${STREAM}" -p qemu -f qcow2.xz --decompress -C ~/.local/share/libvirt/images/
```
