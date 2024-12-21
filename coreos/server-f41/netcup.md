# Fedora CoreOS on netcup root server

## Download iso

```bash
# an alternative would be to use coreos-installer container image
sudo dnf install coreos-installer butane libguestfs virt-filesystems guestfs-tools
export STREAM=stable
# x86_64 or aarch64
export ARCH=aarch64
coreos-installer download -s $STREAM -a $ARCH -p metal -f iso
# qcow2 not available as stream (and what is 4k.raw.xz ?)
coreos-installer download -s $STREAM -a $ARCH -p metal -f raw.xz --decompress
```

## Status

* modified ISO does not boot
* can't modify qcow2 as COREOS_BOOT_DEV is not detected

## Hardware

### VPS 2000 ARM G11 SE NUE ADV24

net dev
eth0 (enp7s0)

disk
/dev/vda

with debian 12:
/dev/vda2   /boot/efi       249556
/dev/vda3   /boot           457816
/dev/vda4   /               1056177868
