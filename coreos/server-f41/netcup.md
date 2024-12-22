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

## Bare Metal Options

* https://docs.fedoraproject.org/en-US/fedora-coreos/bare-metal

### ISO

_Not_ working for unknown reasons. (My tests have used script `coreos-netcup-iso-install.sh`.)

### raw/qcow2 (Matthias' guestfish trick)

*Working*, use script `coreos-netcup-modify-raw.sh`. The raw image is converted to qcow2 because that is much smaller.

* I encounter problems with ssh pub keys in a file. This currently does not work!
  Workaround: Copy ssh pub key into butane file directly.

### PXE

AFAIU, PXE needs a (second) server (matchbox?) that delivers the images. I'm not able to set this up at present.

* [PXE boot testing on libvirt](https://dustymabe.com/2019/01/04/easy-pxe-boot-testing-with-only-http-using-ipxe-and-libvirt/)
* [(ugly PXE support at netcup)](https://forum.netcup.de/administration-eines-server-vserver/vserver-server-kvm-server/p143388-server-per-pxe-pxelinux-booten/?highlight=pxe#post143388)
* [PXELINUX (part of syslinux boot loader)](https://wiki.syslinux.org/wiki/index.php?title=PXELINUX)
  + https://wiki.syslinux.org/wiki/index.php?title=Config
* [coreos PXE](https://docs.fedoraproject.org/en-US/fedora-coreos/live-reference/)
* [coreos download includes netboot images](https://fedoraproject.org/de/coreos/download?stream=stable)
* [netboot quickstart](https://netboot.xyz/docs/quick-start/)
  + [netboot images](https://netboot.xyz/downloads/)
  + [netboot boot page](https://boot.netboot.xyz/)
* [terraform module to setup some machine with matchbox based on Fedora CoreOS](https://github.com/ecky-l/fcos-pxe-bootstrapper)
  + https://forum.netcup.de/administration-eines-server-vserver/vserver-server-kvm-server/p162206-server-per-pxe-pxelinux-booten/?highlight=coreos#post162206
  + https://typhoon.psdn.io/ kubernetes
* [iPXE - open source boot firmware](https://ipxe.org/) for flashing on network card
  + https://github.com/ipxe/ipxe

## RAM booting

It seems to be possible to tweak the ISO case to do that. But after that you need to do a 'real' install _manually_. 
Because of this, I haven't tried.

* https://docs.fedoraproject.org/en-US/fedora-coreos/live-booting/

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
