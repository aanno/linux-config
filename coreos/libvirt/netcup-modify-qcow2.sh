#!/bin/bash -x
# modify qcow2 image and include a ignition file
# https://www.matthiaspreu.com/posts/fedora-coreos-embed-ignition-config/

set -eu

CONFIG_FILE_NAME=netcup

# absolute path needed
IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210217.3.0-qemu.x86_64.qcow2"
MOD_IMAGE=fcos.qcow2
cp "$IMAGE" "$MOD_IMAGE"

fcct -p -s -d . -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" || exit -1

# absolute path needed
IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`
COREOS_BOOT_DEV=$(virt-filesystems -a $MOD_IMAGE -l | grep boot | awk -F ' ' '{print $1}')

cp "$IGNITION_CONFIG" config.ign

guestfish add fcos.qcow2 : \
          run : \
          mount "$COREOS_BOOT_DEV" / : \
          mkdir /ignition : \
          copy-in config.ign /ignition/ : \
          unmount-all : \
          exit

