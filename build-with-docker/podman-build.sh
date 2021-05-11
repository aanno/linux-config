#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`

rm -rf ./opt || true
podman rmi localhost/owntone || true

mkdir -p $CWD/opt/owntone \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo;
rm -rf $CWD/opt/owntone/* || true;
podman build --pull --rm -t owntone \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt/owntone:/opt/owntone:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -f Containerfile.nymphcast.fedora34;
tar cvfz owntone.tar.gz ./opt/

# rm -rf ./opt
# podman rmi localhost/owntone
