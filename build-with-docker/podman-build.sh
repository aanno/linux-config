#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`

mkdir -p $CWD/opt/owntone
rm -rf $CWD/opt/owntone/* || true
podman build --pull --rm -t owntone -v $CWD/opt/owntone:/opt/owntone:z \
  -f Containerfile.ubuntu-hirsute
tar cvfz owntone.tar.gz ./opt/
rm -rf ./opt
podman rmi localhost/owntone
