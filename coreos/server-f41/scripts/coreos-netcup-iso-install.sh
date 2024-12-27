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

  pushd configs

    if [[ ( ! -f "${IGNITION_CONFIG}.ign" ) || ( "${IGNITION_CONFIG}.bu -nt ${IGNITION_CONFIG}.ign" ) ]]; then
      butane --pretty --strict --files-dir butane-embedded ${IGNITION_CONFIG}.bu >${IGNITION_CONFIG}.ign
      if [ $? -ne 0 ]; then
        rm ${IGNITION_CONFIG}.ign
        echo "butane warnings or errors"
        exit -1
      fi
    fi

  popd

ABSOLUTE_IGN=`readlink -f configs/${IGNITION_CONFIG}.ign`

UUID=`uuidgen`

export UUID IPV4_ADDR IPV4_GATEWAY IPV6_ADDR1 IPV6_ADDR2 IPV6_ADDR3 IPV6_GATEWAY IPV6_DNS NET_DEV

envsubst <network/static-ip-template.nmconnection >static-ip.nmconnection

rm netcup-$ARCH.iso || true

# network and console does not seem to need configuration
coreos-installer iso customize \
    --dest-device /dev/vda \
    --dest-ignition ${ABSOLUTE_IGN} \
    -o netcup-$ARCH.iso $IMAGE_ISO

#     --dest-console tty0 \
#     --network-keyfile static-ip.nmconnection \

popd
