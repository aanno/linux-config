#!/bin/bash 

# https://conferencing.siteos.de/
sudo ip route add 194.69.205.60 via 192.168.10.3 dev br0 metric 9
# https://mail.siteos.de/
sudo ip route add 194.69.205.61 via 192.168.10.3 dev br0 metric 9
# https://projektron.siteos.de/bcs/login
sudo ip route add 194.69.205.205 via 192.168.10.3 dev br0 metric 9
# https://siteos.de/
sudo ip route add 194.69.205.197 via 192.168.10.3 dev br0 metric 9

