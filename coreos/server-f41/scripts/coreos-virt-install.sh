#!/bin/bash -x

# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/

export GIT_ROOT=`git rev-parse --show-toplevel`
pushd $GIT_ROOT/coreos/server-f41

if [ ! -f .env-virt.sh ]; then
  echo "missing file .env-virt.sh (template is env-virt-example.sh)"
  exit -1
fi
source .env-virt.sh

if [ ${IGNITION_CONFIG}.bu -nt ${IGNITION_CONFIG}.ign ]; then
  butane --pretty --strict --files-dir butane-embedded ${IGNITION_CONFIG}.bu >${IGNITION_CONFIG}.ign
fi

ABSOLUTE_IGN=`readlink -f ${IGNITION_CONFIG}.ign`

# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=$ABSOLUTE_IGN")

# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${ABSOLUTE_IGN}

# perhaps you must ensure that pool server-f41 exists
# I recommend using a plain bridge (br0) instead of an virtual routing bridge (virbr0)
virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE},pool=server-f41" \
        --network bridge=br0 "${IGNITION_DEVICE_ARG[@]}"

popd
