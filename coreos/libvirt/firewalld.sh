#!/bin/sh -x

set -eu

# https://www.server-world.info/en/note?os=CentOS_7&p=firewalld&f=2
# https://unix.stackexchange.com/questions/539828/how-to-use-postrouting-snat-with-firewalld
# get zones right
nmcli c mod enp1s0 connection.zone external
nmcli c mod wg0 connection.zone internal

# nat
# hint: Warning: ALREADY_ENABLED: masquerade already enabled in 'external'
firewall-cmd --zone=external --add-masquerade

# [5] outgoing packets through the Server from Internal network(192.168.159.0/24) are allowed and forwarded to External side
firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o enp1s0 -j MASQUERADE
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i wg0 -o enp1s0 -j ACCEPT
# hint: ALREADY_ENABLED: rule '('-i', 'wg0', '-o', 'enp1s0', '-j', 'ACCEPT')' already is in 'ipv4:filter:FORWARD'
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i enp1s0 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT 
# todo ipv6 rules

# services
firewall-cmd --zone=external --add-service http --add-service https --add-service ssh --add-service cockpit
firewall-cmd --zone=internal --add-service http --add-service https --add-service ssh --add-service cockpit --add-service dhcpv6-client --add-service mdns --add-service samba-client 

# make permanent
# firewall-cmd --runtime-to-permanent

# check and print
firewall-cmd --get-active-zones
firewall-cmd --check-config
firewall-cmd --zone=external --query-masquerade
firewall-cmd --zone=external --list-all 
firewall-cmd --zone=internal --list-all 
# dump complete rules
# nft list ruleset
