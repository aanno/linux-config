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

#### Links

nm:
* https://unix.stackexchange.com/questions/501260/where-does-network-manager-store-settings

netplan:
* https://askubuntu.com/questions/1412503/setting-up-a-bridge-for-host-and-vm
