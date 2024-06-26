#!/bin/bash
# make a local vm from coreos image

set -eu
. env.sh

CONFIG_FILE_NAME=my
VM_NAME="fcos-37"
TMP=`mktemp -d`

fcct -p -s -d . -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" || exit -1
cp "${CONFIG_FILE_NAME}.ign" "$TMP/${CONFIG_FILE_NAME}.ign"

# absolute path needed
# IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`
IGNITION_CONFIG="$TMP/${CONFIG_FILE_NAME}.ign"
chmod -R o+rx "$TMP"
# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t "$TMP/${CONFIG_FILE_NAME}.ign"


virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}" \
        --mac="52:54:00:a8:c2:c8" \
        --network "${NETWORK}"

rm -rf "$TMP"

