#!/bin/bash -x

CONFIG_FILE_NAME=my

# absolute path needed
IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210201.3.0-qemu.x86_64.qcow2"

scp -P 2222 "$IMAGE" "$NC_USER@46.38.225.190:/image"

