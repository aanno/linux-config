#!/bin/bash -x

set -ehu -o pipefail

# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/

export GIT_ROOT=`git rev-parse --show-toplevel`
pushd $GIT_ROOT/coreos/server-f41

# source netcup stuff AND THEN virt stuff
if [ ! -f .env-netcup.sh ]; then
  echo "missing file .env-netcup.sh (template is env-netcup-example.sh)"
  exit -1
fi
source .env-netcup.sh

if [ ! -f .env-virt.sh ]; then
  echo "missing file .env-virt.sh (template is env-virt-example.sh)"
  exit -1
fi
source .env-virt.sh

source scripts/but-to-ign.sh
export IGNITION_CONFIG NET_DEV ROOT_DISK ROOT_PART_SIZE BACKUP_PART_SIZE

but_to_ign

ABSOLUTE_IGN=`readlink -f configs/${IGNITION_CONFIG}.ign`

# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=$ABSOLUTE_IGN")

# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${ABSOLUTE_IGN}

# perhaps you must ensure that pool server-f41 exists
# I recommend using a plain bridge (br0) instead of an virtual routing bridge (virbr0)
# https://www.smoothnet.org/qemu-tpm/
# swtpm at /usr/bin/swtpm does not support TPM 2
virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE},pool=server-f41,bus=virtio" \
        --network bridge=br0,model=virtio "${IGNITION_DEVICE_ARG[@]}" \
        --tpm backend.type=emulator,backend.version=2.0,model=tpm-tis

# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${VM_NAME}*.qcow2

popd
