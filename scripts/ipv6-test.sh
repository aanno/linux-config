#!/bin/bash -x

# find out our external ipv4 ip
IPV4=`host -4 netzgeneration.no-ip.biz | cut -d ' ' -f 4`

# update our ipv6 tunnel
# https://www.tunnelbroker.net/forums/index.php?topic=1994.0
# wget --prefer-family=ipv4 -q -O - "https://ipv4.tunnelbroker.net/nic/update?username=&password=&hostname="

host ipv6.google.com
ping6 -c 2 ipv6.google.com
wget -O /dev/null ipv6.google.com
