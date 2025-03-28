#!/bin/bash -x
# https://docs.fedoraproject.org/en-US/fedora-coreos/sysconfig-network-configuration/
#
# NOT WORKING! (at least on arm64)
# for unknown reasons (boot loop!)
# https://github.com/canonical/lxd/issues/7191

set -ehu -o pipefail

export GIT_ROOT=`git rev-parse --show-toplevel`
pushd $GIT_ROOT/coreos/server-f41

if [ ! -f .env-netcup.sh ]; then
  echo "missing file .env-netcup.sh (template is env-netcup-example.sh)"
  exit -1
fi
source .env-netcup.sh

source scripts/but-to-ign.sh
export IGNITION_CONFIG NET_DEV ROOT_DISK ROOT_PART_SIZE BACKUP_PART_SIZE

UUID=`uuidgen`

export UUID IPV4_ADDR IPV4_GATEWAY IPV6_ADDR1 IPV6_ADDR2 IPV6_ADDR3 IPV6_ADDR4 IPV6_ADDR5 IPV6_ADDR6 IPV6_GATEWAY IPV6_DNS NET_DEV

envsubst <network/static-ip-template.nmconnection >configs/butane-embedded/static-ip.nmconnection

but_to_ign

ABSOLUTE_IGN=`readlink -f configs/${IGNITION_CONFIG}.ign`

rm netcup-$ARCH.iso || true

# network and console does not seem to need configuration
coreos-installer iso customize \
    --dest-device /dev/vda \
    --dest-ignition ${ABSOLUTE_IGN} \
    -o netcup-$ARCH.iso $IMAGE_ISO

#     --dest-console tty0 \
#     --network-keyfile configs/butane-embedded/static-ip.nmconnection \

popd
