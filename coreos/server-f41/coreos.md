# Fedora CoreOS

* https://docs.fedoraproject.org/en-US/fedora-coreos/
* [hint for 4k raw image](https://stevetech.me/posts/find-4k-native-ssds)
  + https://en.wikipedia.org/wiki/Advanced_Format#4K_native
* [download for stable stream](https://fedoraproject.org/de/coreos/download?stream=stable&arch=x86_64#download_section)
* [internals](https://github.com/coreos/fedora-coreos-tracker/blob/main/internals/README-internals.md)
* [internals about initramfs](https://github.com/coreos/fedora-coreos-tracker/blob/main/internals/README-initramfs.md)

## gotchas

* problem with letsencrypt certificate (amce)
  + disable ipv6 (if not setup properly): https://www.cyberciti.biz/faq/how-to-temporarily-disable-ipv6-in-linux/
* firewalld is active on default
  + disable firewall: `sudo systemctl stop firewalld`
* reset aio: https://github.com/nextcloud/all-in-one#how-to-properly-reset-the-instance

## Ignition

* [butane spec](https://coreos.github.io/butane/specs/) fcos, flatcar, openshift
* [ignition file spec](https://coreos.github.io/ignition/specs/)

### run Ignition more than once

* force Ignition
  + recreate `/boot/ignition.firstboot` file or
  + start with kernel parameter `ignition.firstboot`
  + details: [firstboot support on read-only root file systems](https://github.com/coreos/ignition/issues/1049)
* [some rules for running ignition more than once](https://docs.fedoraproject.org/en-US/fedora-coreos/live-booting/)
  + don't use 'wipe*'
  + use LUKS only with 'key_file' (no clevis nor tpm!)
  + don't use RAID
  + don't use append
  + When writing files in persistent storage, set overwrite to true to avoid Ignition failures
* [Filesystem-Reuse Semantics](https://coreos.github.io/ignition/operator-notes/#filesystem-reuse-semantics)

#### problems running ignition more than once

At present LUKS hinders the second ignition with the following error:

```bash
Jan 04 19:28:45 ignition[1509]: Ignition failed: creating crypttab entries: adding luks related files: error creating /sysroot/etc/luks/luks-backup: error creating file "/sysroot/etc/luks/luks-backup": A file exists there already and overwrite is false
Jan 04 19:31:08 systemd[1]: ignition-remount-sysroot.service: Failed with result 'exit-code'.
Jan 04 19:31:08 systemd[1]: Failed to start ignition-remount-sysroot.service - Remount /sysroot read-write for Ignition.
```

In addition after this problem, the (installed) coreos is no longer useable:

```bash
Please enter passphrase for disk var (luks-var): (press TAB for no echo)
```

Even if you've got a backup of the /etc/luks/* file, providing them leads to

```bash
an 04 19:56:31 ignition[1539]: Ignition failed: creating crypttab entries: adding luks related files: error creating /sysroot/etc/luks/luks-backup: error creating file "/sysroot/etc/luks/luks-backup": A file exists there already and overwrite is false
```

## Partitions

* [Storage](https://docs.fedoraproject.org/en-US/fedora-coreos/storage/)
* [Identify and match existing partitions based on label](https://github.com/coreos/ignition/issues/1219)

The root device is mostly /dev/vda or /dev/sda.

* Partition #1 is bios-boot
* Partition #2 is EFI
* Partition #3 is boot (linux kernels, vmlinuz, initramfs)
* Partition #4 is coreos root (/)
* After that all other partitions follow

### Example 1

netcup VPS 2000 ARM G11 SE NUE ADV24 with minimal configuration:

```bash
$ sudo gdisk -l /dev/vda
GPT fdisk (gdisk) version 1.0.10

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.
Disk /dev/vda: 2147483648 sectors, 1024.0 GiB
Sector size (logical/physical): 512/512 bytes
Disk identifier (GUID): F58D9859-CEAF-4E78-A8AE-B057FF98E8F5
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 2048, last usable sector is 2147483614
Partitions will be aligned on 2048-sector boundaries
Total free space is 0 sectors (0 bytes)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  8301  reserved
   2            4096          264191   127.0 MiB   EF00  EFI-SYSTEM
   3          264192         1050623   384.0 MiB   8300  boot
   4         1050624      2147483614   1023.5 GiB  8300  root
```

### Example 2

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

Parameters:
1. ROOT_PART_SIZE=8000 (start_mib of backup)
2. BACKUP_PART_SIZE=2000 (size_mib of backup)

### Example 3

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
Disk identifier (GUID): 644DF9DD-13D7-496A-A3AB-15DF8E404C62
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 2048, last usable sector is 41940992
Partitions will be aligned on 2048-sector boundaries
Total free space is 0 sectors (0 bytes)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048            4095   1024.0 KiB  EF02  BIOS-BOOT
   2            4096          264191   127.0 MiB   EF00  EFI-SYSTEM
   3          264192         1050623   384.0 MiB   8300  boot
   4         1050624        25626623   11.7 GiB    8300  root
   5        25626624        29722623   2.0 GiB     8300  backup
   6        29722624        41940992   5.8 GiB     8300  var
```

Parameters:
1. ROOT_PART_SIZE=12000 (size_mib of root)
2. BACKUP_PART_SIZE=2000 (size_mib of backup)

### Links

* [resize fcos boot partition](https://www.aleskandro.com/posts/resize-boot-partition-fedora-coreos/)

## LUKS

### key_file

```bash
dd bs=512 count=4 if=/dev/random of=$DEST iflag=fullblock
```

* [How to enable LUKS disk encryption with keyfile on Linux](https://www.cyberciti.biz/hardware/cryptsetup-add-enable-luks-disk-encryption-keyfile-linux/)

# Mounts

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
