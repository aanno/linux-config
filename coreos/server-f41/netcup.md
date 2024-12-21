# Fedora CoreOS on netcup root server

## Download iso

```bash
# an alternative would be to use coreos-installer container image
sudo dnf install coreos-installer butane
export STREAM=stable
coreos-installer download -s stable -p metal -f iso
```

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
