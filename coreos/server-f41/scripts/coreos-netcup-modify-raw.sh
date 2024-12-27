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

  pushd configs

    if [[ ( ! -f "${IGNITION_CONFIG}.ign" ) || ( "${IGNITION_CONFIG}.bu -nt ${IGNITION_CONFIG}.ign" ) ]]; then
      butane --pretty --strict --files-dir butane-embedded ${IGNITION_CONFIG}.bu >${IGNITION_CONFIG}.ign
      if [ $? -ne 0 ]; then
        rm ${IGNITION_CONFIG}.ign
        echo "butane warnings or errors"
        exit -1
      fi
    fi

  popd

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
