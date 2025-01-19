#!/bin/bash -x
# modify qcow2 image and include a ignition file
# https://www.matthiaspreu.com/posts/fedora-coreos-embed-ignition-config/

set -ehu -o pipefail

if [ ! -f .env-netcup.sh ]; then
  echo "missing file .env-netcup.sh (template is env-netcup-example.sh)"
  exit -1
fi
source .env-netcup.sh

MOD_IMAGE=custom-$ARCH.raw

export GIT_ROOT=`git rev-parse --show-toplevel`
pushd $GIT_ROOT/coreos/server-f41

source scripts/but-to-ign.sh
export IGNITION_CONFIG NET_DEV ROOT_DISK ROOT_PART_SIZE BACKUP_PART_SIZE

UUID=`uuidgen`

export UUID IPV4_ADDR IPV4_GATEWAY IPV6_ADDR1 IPV6_ADDR2 IPV6_ADDR3 IPV6_ADDR4 IPV6_ADDR5 IPV6_ADDR6 IPV6_GATEWAY IPV6_DNS NET_DEV

rm configs/butane-embedded/static-ip.nmconnection
envsubst <network/static-ip-template.nmconnection >configs/butane-embedded/static-ip.nmconnection

but_to_ign

ABSOLUTE_IGN=`readlink -f configs/${IGNITION_CONFIG}.ign`

rm "$MOD_IMAGE" || true
cp "$IMAGE_RAW" "$MOD_IMAGE"

COREOS_BOOT_DEV=$(virt-filesystems -a $MOD_IMAGE -l | grep boot | awk -F ' ' '{print $1}')

cp "$ABSOLUTE_IGN" config.ign

guestfish add $MOD_IMAGE : \
          run : \
          mount "$COREOS_BOOT_DEV" / : \
          mkdir /ignition : \
          copy-in config.ign /ignition/ : \
          unmount-all : \
          exit

# qcow2 images are substantial smaller
rm custom-$ARCH.qcow2 || true
qemu-img convert -O qcow2 $MOD_IMAGE custom-$ARCH.qcow2

popd
