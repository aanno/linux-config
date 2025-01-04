# Fedora CoreOS

* https://docs.fedoraproject.org/en-US/fedora-coreos/
* [hint for 4k raw image](https://stevetech.me/posts/find-4k-native-ssds)
  + https://en.wikipedia.org/wiki/Advanced_Format#4K_native
* [download for stable stream](https://fedoraproject.org/de/coreos/download?stream=stable&arch=x86_64#download_section)
* [internals](https://github.com/coreos/fedora-coreos-tracker/blob/main/internals/README-internals.md)
* [internals about initramfs](https://github.com/coreos/fedora-coreos-tracker/blob/main/internals/README-initramfs.md)


## Ignition

* [ignition file spec](https://coreos.github.io/ignition/specs/)

### run Ignition more than once

* force Ignition
  + recreate `/boot/ignition.firstboot` file or
  + start with kernel parameter `ignition.firstboot`
  + details: [firstboot support on read-only root file systems](https://github.com/coreos/ignition/issues/1049)
* [some rules for running ignition more than once](https://docs.fedoraproject.org/en-US/fedora-coreos/live-booting/)
  + don't use 'wipe*'
  + use LUKS only with 'key_file' or 'tpm'
  + don't use RAID
  + When writing files in persistent storage, set overwrite to true to avoid Ignition failures

## Partitions

The root device (mostly /dev/vda or /dev/sda):

```bash
# gdisk -l /dev/vda
GPT fdisk (gdisk) version 1.0.10

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.
Disk /dev/vda: 41943040 sectors, 20.0 GiB
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): ED165AF7-09A1-459C-8C52-BE328B5A9B10
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 2048, last usable sector is 41943006
Partitions will be aligned on 2048-sector boundaries
Total free space is 2014 sectors (1007.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  EF02  BIOS-BOOT
   2            4096          264191   127.0 MiB   EF00  EFI-SYSTEM
   3          264192         1050623   384.0 MiB   8300  boot
   4         1050624        16383999   7.3 GiB     8300  root
   5        16384000        20479999   2.0 GiB     8300  backup
   6        20480000        41940992   10.2 GiB    8300  var
```

Hence:

* Partition #1 is bios-boot
* Partition #2 is EFI
* Partition #3 is boot (linux kernels, vmlinuz, initramfs)
* Partition #4 is coreos root (/)
* After that all other partitions follow

### Links

* [resize fcos boot partition](https://www.aleskandro.com/posts/resize-boot-partition-fedora-coreos/)

## Mounts

```bash
# cat /etc/crypttab 
root UUID=a54b1fa0-fac4-483e-9920-1a283f787f71 none luks
luks-backup UUID=880ad382-b9a5-472e-bbc7-e169e732ae44 none luks
luks-var UUID=19fcdec9-4f5b-428d-8eca-4b7ce9366463 none luks
# mount  | grep -E 'vd|mapper'
/dev/mapper/root on /sysroot type xfs (ro,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,prjquota)
/dev/mapper/root on /etc type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,prjquota)
/dev/mapper/root on /sysroot/ostree/deploy/fedora-coreos/var type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,prjquota)
/dev/mapper/luks-var on /var type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/mapper/luks-backup on /var/backup type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
/dev/vda3 on /boot type ext4 (ro,nosuid,nodev,relatime,seclabel)
```

Hence:

* LVM2 is _not_ in use but LUKS is
* root (/) fs is mapped several times, formatted as xfs and _encrypted_
* /boot fs is formatted as ext4 and _not_ encrypted
* other partitions are encrypted _if defined as LUKS_

## Wireguard

* [wg-easy](https://github.com/wg-easy/wg-easy) one-stop solution for wireguard in container

## Starting containers with systemd

* [podman-systemd.unit](https://docs.podman.io/en/latest/markdown/podman-systemd.unit.5.html)
* [running containers](https://docs.fedoraproject.org/en-US/fedora-coreos/running-containers/)
