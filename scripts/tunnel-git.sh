#!/bin/bash -x

# Attention: Ports are shifted!

ssh -X \
  -L2180:192.168.1.16:80 \
  -L8081:192.168.1.14:8081 \
  -L5000:192.168.1.14:5000 \
  -L3306:192.168.1.74:3306 \
  -L9200:192.168.1.211:9200 \
  -L5900:192.168.1.131:5900 \
  tpasch@noah1

# not working
#  -L2143:192.168.1.16:443 \    gitlab tls
#  -L2122:192.168.1.16:22 \     gitlab git@

# description
#  -L2180:192.168.1.16:80 \     gitlab http
#  -L8081:192.168.1.14:8081 \   nexus http
#  -L8081:192.168.1.14:5000 \   nexus docker repo
#  -L3306:192.168.1.74:3306 \   mariadb
#  -L9200:192.168.1.211:9200 \  elasticsearch
#  -L5900:192.168.1.131:5900 \  spice

