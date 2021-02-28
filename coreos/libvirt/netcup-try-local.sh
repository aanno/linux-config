#!/bin/bash
# make a local vm from coreos image

CONFIG_FILE_NAME=my

# absolute path needed
# IMAGE="$HOME/.local/share/libvirt/images/fedora-coreos-33.20210201.3.0-qemu.x86_64.qcow2"
IMAGE=`readlink -f fcos.qcow2`
VM_NAME="fcos-netcup-33"
VCPUS="2"
RAM_MB="8192"
DISK_GB="20"
STREAM="stable"

fcct -p -s -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" 

# absolute path needed
IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`

virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --qemu-commandline="-fw_cfg name=opt.gone/gone.com.coreos/config,file=${IGNITION_CONFIG}" \
        --network network=default

# networking tp:
# 
# --network network=default
# (Default) libvirt NAT networking: Networking will work, but services will only
# be available on dom0. CoreOS will report (local) ip address, like in
# 
# enp1s0: 192.168.122.91 fe80::5054:ff:fe8a:5fc2
# 

