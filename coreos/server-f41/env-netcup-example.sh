# copy this as `.env-netcup.sh` and adapt to your needs

STREAM="stable"
# x86_64 or aarch64
ARCH=aarch64
IGNITION_CONFIG="minimal"

IMAGE_ISO=`ls fedora-coreos-41.*-live.$ARCH.iso`
IMAGE_RAW=`ls fedora-coreos-41.*-metal.$ARCH.raw`

NET_DEV=enp7s0
# /dev/sda or /dev/vda
ROOT_DISK=/dev/sda
# root partition size (at least 8GB probably more is better)
ROOT_PART_SIZE=8000
# backup partion size
BACKUP_PART_SIZE=2000

# not needed (dhcp)
IPV4_ADDR=
IPV4_GATEWAY=

IPV6_ADDR1=
IPV6_ADDR2=
IPV6_ADDR3=
IPV6_GATEWAY=
IPV6_DNS=

# must be absolute paths, hence
IMAGE_ISO=`readlink -f $IMAGE_ISO`
IMAGE_RAW=`readlink -f $IMAGE_RAW`
