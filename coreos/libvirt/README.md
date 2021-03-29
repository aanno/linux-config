# Fedora CoreOS (FCOS)


## Run once

* (Only) use local `dnscrypt-proxy` as resolver
  + `sudo resolvectl dns enp1s0 127.0.0.1 ::1`
* Enable cockpit (see https://cockpit-project.org/running#coreos)
  + `sudo podman container runlabel --name cockpit-ws RUN docker.io/cockpit/ws`
  + `sudo podman container runlabel INSTALL docker.io/cockpit/ws`
  + `sudo systemctl enable cockpit.service`

## Config

* [fcc examples](https://coreos.github.io/fcct/examples/)
* [vultr example](https://www.vultr.com/docs/ignition)

## On netcup

* https://www.matthiaspreu.com/posts/fedora-coreos-embed-ignition-config/
* https://forum.netcup.de/administration-eines-server-vserver/vserver-server-kvm-server/p140914-installation-von-fedora-coreos-auf-vps

## Firewall

* https://github.com/coreos/fedora-coreos-tracker/issues/467


## Cool self-hosting software

* [mistborn](https://gitlab.com/cyber5k/mistborn) run our own privacy protecting family server


## Config Fedora

* Groups of user(s):
  ```
  $ id
  uid=1000(tpasch) gid=1000(tpasch) Gruppen=1000(tpasch),10(wheel),11(cdrom),18(dialout),19(floppy),20(games),33(tape),100(users),500(hugetlb),968(libvirt),971(vboxusers),973(docker) Kontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
  ```
* Also: kvm (?), qemu (?)
* `usermod -a -G examplegroup exampleusername`
### Configure bridge

File `/etc/rc.local`:
```sh
#!/bin/sh
nmcli con down enp1s0 || true
nmcli con up bridge-br0 || true
true
```

* Configure br0 like described at https://wiki.archlinux.org/index.php/Network_bridge (NetworkManager method)
* `chmod u+x /etc/rc.local`
* `ln -s /etc/rc.local /etc/rc.d/rc.local`
* `systemctl enable rc-local.service`
* `systemctl start rc-local.service`
* `sudo virsh net-define br0` (from xml in file 'br0')
* `sudo virsh net-start br0`

### Install libvirt (virt-manager)

* `sudo dnf install virt-manager virt-install qemu-kvm libvirt-daemon-driver-storage libvirt-daemon-driver-qemu`
* Enable services: virtlogd, virtqemud, virtstoraged, libvirtd, libvirt-guests
* https://sysadminde.com/questions/840519/how-to-change-the-default-storage-pool-from-libvirt
  + `virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images`
  + `virsh pool-edit default`
  + `virsh pool-list`

### Misc

File `/etc/rc.local`:
```sh
#!/bin/bash

/usr/bin/echo "rc.local"
/usr/bin/systemctl start acpid.service

/usr/sbin/brctl addif br0 eno1

#echo "advise" >/sys/kernel/mm/transparent_hugepage/shmem_enabled 
/usr/bin/echo "always" >/sys/kernel/mm/transparent_hugepage/shmem_enabled 
# echo defer+madvise >/sys/kernel/mm/transparent_hugepage/defrag
/usr/bin/echo defer >/sys/kernel/mm/transparent_hugepage/defrag

/usr/bin/ulimit -l 1024

/usr/bin/hugeadm --pool-pages-max 2M:2048
/usr/bin/hugeadm --thp-always
/usr/bin/hugeadm --create-group-mounts hugetlb

/usr/bin/hugeadm --set-recommended-min_free_kbytes
/usr/bin/hugeadm --set-recommended-shmmax

/usr/bin/true
```
