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

IP_ADDR=`ip addr show  dev br0`
IP_ADDR_INET=`echo -e "$IP_ADDR" | grep "inet "`

if [ -z "$IP_ADDR_INET" ]; then

  sudo ip link add br0 type bridge
  sudo ip link set br0 up
  sudo ip link set eno1 master br0
  sleep 3
  nmcli connection up bridge-br0
  sleep 5
  ip a

fi

popd
