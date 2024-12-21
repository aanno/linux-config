#!/bin/bash -x

# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/

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

ABSOLUTE_IGN=`readlink -f ${IGNITION_CONFIG}.ign`

coreos-installer iso customize \
    --dest-device /dev/vda \
    --dest-ignition ${ABSOLUTE_IGN}.ign \
    --dest-console tty0 \
    --network-keyfile static-ip.nmconnection \
    -o custom.iso $IMAGE

popd
