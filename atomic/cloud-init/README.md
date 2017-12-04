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
