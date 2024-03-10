#!/bin/bash -x

nmcli con down "Wired Connection" && \
nmcli con up bridge-br0;
