# copy this as `.env-netcup.sh` and adapt to your needs

IGNITION_CONFIG="minimal"
IMAGE=`ls fedora-coreos-41.*-live.x86_64.iso`
STREAM="stable"

# not needed (dhcp)
IPV4_ADDR=
IPV4_GATEWAY=

IPV6_ADDR=
IPV6_GATEWAY=

# must be absolute paths, hence
IMAGE=`readlink -f $IMAGE`
