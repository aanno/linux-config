#!/bin/bash -x
# https://docs.fedoraproject.org/en-US/fedora-coreos/sysconfig-network-configuration/
#
# NOT WORKING! (at least on arm64)
# tty0 error message:
# BdsDxe: failed to load Boot004 "UEFI PXEv4 (MAC: )"
#
# Perhaps secure boot problem?
# https://github.com/canonical/lxd/issues/7191
# boot with
# security.secureboot=false

export GIT_ROOT=`git rev-parse --show-toplevel`
pushd $GIT_ROOT/coreos/server-f41

if [ ! -f .env-netcup.sh ]; then
  echo "missing file .env-netcup.sh (template is env-netcup-example.sh)"
  exit -1
fi
source .env-netcup.sh

if [ ${IGNITION_CONFIG}.bu -nt ${IGNITION_CONFIG}.ign ]; then
  butane --pretty --strict --files-dir butane-embedded ${IGNITION_CONFIG}.bu >${IGNITION_CONFIG}.ign
fi

UUID=`uuidgen`
ABSOLUTE_IGN=`readlink -f ${IGNITION_CONFIG}.ign`

export UUID IPV4_ADDR IPV4_GATEWAY IPV6_ADDR1 IPV6_ADDR2 IPV6_ADDR3 IPV6_GATEWAY IPV6_DNS NET_DEV

envsubst <network/static-ip-template.nmconnection >static-ip.nmconnection

rm custom.iso || true

coreos-installer iso customize \
    --dest-device /dev/vda \
    --dest-ignition ${ABSOLUTE_IGN} \
    --dest-console tty0 \
    --network-keyfile static-ip.nmconnection \
    -o custom.iso $IMAGE

popd
