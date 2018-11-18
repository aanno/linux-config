#!/bin/bash -x

export HOST=ipa.redsnapper.fritz.box
export IPA_DATA=ipa-data
#export IP_ADDR=192.168.10.59
export IP_ADDR=172.17.0.2

# dnsmasq hinders: (tp)
# -p 53:53/udp -p 53:53 \
docker run --name freeipa-server-container -ti \
   -e IPA_SERVER_IP=$IP_ADDR \
   -p 80:80 -p 443:443 -p 389:389 -p 636:636 -p 88:88 -p 464:464 \
   -p 88:88/udp -p 464:464/udp -p 123:123/udp -p 7389:7389 \
   -p 9443:9443 -p 9444:9444 -p 9445:9445 \
   -h $HOST \
   -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
   --tmpfs /run --tmpfs /tmp \
   -v $IPA_DATA:/data:Z freeipa/freeipa-server
