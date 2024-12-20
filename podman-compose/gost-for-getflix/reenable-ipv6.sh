#!/bin/bash -x
# for the time ghost proxy is there, disable ipv6
# as proxy is ipv4 only (and there is no way to get ipv6 over it)
# see https://www.cyberciti.biz/faq/how-to-temporarily-disable-ipv6-in-linux/
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0

