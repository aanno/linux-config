#!/bin/bash

CONFIG_FILE_NAME=my

# absolute path needed
IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20201201.3.0-qemu.x86_64.qcow2"
VM_NAME="fcos-33"
VCPUS="4"
RAM_MB="8192"
DISK_GB="20"
STREAM="stable"

fcct -p -s -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" 

# absolute path needed
IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`

virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}"

