#!/bin/bash

ip link set dev enp3s0 down
ip link set dev br0 down
ip addr del 192.168.1.130/24 dev enp3s0

ip link set dev br0 up

brctl addif br0 enp3s0

ip link set dev enp3s0 up
dhclient
systemctl restart NetworkManager

true

