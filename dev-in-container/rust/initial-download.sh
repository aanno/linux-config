#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`/../../build-with-docker

curl -o rustup.sh --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
curl -o install-pdm.py -sSL https://pdm-project.org/install-pdm.py
curl -o volta.sh https://get.volta.sh

