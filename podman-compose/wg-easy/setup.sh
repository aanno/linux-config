#!/bin/bash -x

podman pull ghcr.io/wg-easy/wg-easy

for i in ip_tables iptable_filter iptable_nat wireguard xt_MASQUERADE ; do
    sudo modprobe $i
done
