#!/bin/bash -x

# https://www.cyberciti.biz/faq/how-to-add-network-bridge-with-nmcli-networkmanager-on-linux/
CON=`nmcli con show`
if [ `echo $CON | grep -ci bridge-br0` -eq 0 ]; then
  sudo nmcli con add type bridge ifname br0
fi
if [ `echo $CON | grep -ci bridge-slave-eno1` -eq 0 ]; then
  nmcli con add type bridge-slave ifname eno1 master bridge-br0
fi
nmcli con down bridge-br0
sleep 1
nmcli con down "Wired Connection"
sleep 1
nmcli con up bridge-br0
sleep 3
sudo dhclient -r br0
# -1
#nmcli con add ifname br0 type bridge con-name br0
#nmcli con add type bridge-slave ifname eno1 master br0
#nmcli connection show
