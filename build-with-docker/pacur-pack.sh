#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`

rm -rf nymphcast-all* opt || true
podman run --rm -t -v $CWD:/pacur:z localhost/pacur/fedora-34
rpm -qlp nymphcast-all-0.0.1-1.fc34.x86_64.rpm
