Setup virt-manager and libvirt:
* https://fedoraproject.org/wiki/Getting_started_with_virtualization

Setup bridged networking:
* http://wiki.libvirt.org/page/Networking

(Optional) setup remote ssh vm access:
* http://wiki.libvirt.org/page/SSHSetup

Quickstart with atomic (raw image on libvirt):
* https://www.projectatomic.io/docs/quickstart/
* http://cloudinit.readthedocs.io/en/latest/

```
mkisofs -output init.iso -volid cidata -joliet -rock user-data meta-data
```

Image format could be 'raw' or 'qcow2':
```
virt-install --name atomic01 \
--description 'Fedora Atomic Host 01' \
--ram 2048 \
--vcpus 1 \
--disk path=/var/lib/libvirt/images/Fedora-Atomic-27/Fedora-Atomic-27-20171129.0.x86_64.raw \
--os-type linux \
--os-variant fedora26 \
--network bridge=br0 \
--graphics vnc,listen=127.0.0.1,port=5901 \
--cdrom /var/lib/libvirt/images/Fedora-Atomic-27/init.iso \
--noautoconsole
```

Networking:
* DNS on nmcli: https://askubuntu.com/questions/721080/how-to-change-dns-of-network-from-terminal
* ip command: https://www.tecmint.com/ip-command-examples/

$ cat ifcfg-enp5s0
```
HWADDR=78:2B:CB:EC:E0:EE
TYPE=Ethernet
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes

# tp bridge for libvirt
# http://wiki.libvirt.org/page/Networking
BRIDGE=br0
NM_CONTROLLED=yes

# tp (not working)
# https://fedoraproject.org/wiki/Tools/NetworkManager/IPv6
NAME=enp5s0
UUID=c4751125-f05e-4402-9c55-96cf792c0a5b
ONBOOT=yes
PEERDNS=yes
PEERROUTES=yes
IPV6_PRIVACY=rfc3041
ZONE=public
ETHTOOL_OPTS="autoneg on"
```

$ cat ifcfg-br0
```
DEVICE=br0
TYPE=Bridge
BOOTPROTO=dhcp
ONBOOT=yes
NM_CONTROLLED=yes
STP=no
PROXY_METHOD=none
BROWSER_ONLY=no
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
NAME=$'Br\703\674cke br0'
UUID=d2d68553-f97e-7549-7a26-b34a26f29318
ZONE=trusted
```

Known Problems:
* keymap & keyboard layout

Kubernetes and Docker
* http://www.projectatomic.io/docs/gettingstarted/
* http://www.projectatomic.io/docs/atomic-host-networking/
