#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
# TODO
# CWD=/var/home/tpasch/scm/linux-config/build-with-docker
CWD=/home/tpasch/dev/scm/aanno/github/linux-config
REALCWD=`pwd`
# USERID=1001
USERID=1000

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;
# rm -rf $CWD/opt/owntone/* || true;
podman run --rm -it \
  --userns=keep-id:uid=$USERID,gid=$USERID \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/.cargo:/home/vscode/.cargo:z \
  -v $CWD/.rustup:/home/vscode/.rustup:z \
  -v $REALCWD:/build:z \
  localhost/rust \
  /bin/bash;

  # registry.fedoraproject.org/fedora:42 \
