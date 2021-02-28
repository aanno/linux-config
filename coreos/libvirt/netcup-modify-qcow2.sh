#!/bin/bash -x
# modify qcow2 image and include a ignition file
# https://www.matthiaspreu.com/posts/fedora-coreos-embed-ignition-config/

CONFIG_FILE_NAME=my

# absolute path needed
IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210201.3.0-qemu.x86_64.qcow2"
MOD_IMAGE=fcos.qcow2
cp "$IMAGE" "$MOD_IMAGE"

fcct -p -s -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" 

# absolute path needed
IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`
COREOS_BOOT_DEV=$(virt-filesystems -a $MOD_IMAGE -l | grep boot | awk -F ' ' '{print $1}')

guestfish add fcos.qcow2 : \
          run : \
          mount "$COREOS_BOOT_DEV" / : \
          mkdir /ignition : \
          copy-in "$IGNITION_CONFIG" /ignition/ : \
          unmount-all : \
          exit

