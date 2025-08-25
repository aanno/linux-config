#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
CWD=/home/tpasch/dev/scm/aanno/github/linux-config/build-with-docker
REALCWD=`pwd`
# USERID=1001
USERID=1000

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf ;

podman run --rm -it \
  --userns=keep-id:uid=$USERID,gid=$USERID \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $PNPM_CACHE_DIR:/pnpm:z \
  -v $PIP_CACHE_DIR:/pip:z \
  -v $VOLTA_HOME/tools:/home/vscode/.volta/tools:z \
  localhost/c-cpp \
  /bin/bash;
