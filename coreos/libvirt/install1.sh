#!/bin/bash

# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
# fcos 33: use coreos-install

mkdir -p $HOME/.local/share/libvirt/images

STREAM="stable"
# as an installed binary:
coreos-installer download -s "${STREAM}" -p qemu -f qcow2.xz --decompress -C ~/.local/share/libvirt/images/
# or as a container:
podman run --pull=always --rm -v $HOME/.local/share/libvirt/images/:/data -w /data \
    quay.io/coreos/coreos-installer:release download -s "${STREAM}" -p qemu -f qcow2.xz --decompress
