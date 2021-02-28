#!/bin/bash -x

CONFIG_FILE_NAME=my

# IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210201.3.0-qemu.x86_64.qcow2"
IMAGE=fcos.qcow2

scp -P 2222 "$IMAGE" "$NC_USER@46.38.225.190:/image"

