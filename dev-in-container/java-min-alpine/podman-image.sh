#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
CWD=/home/tpasch/scm/aanno/github/linux-config/build-with-docker
REALCWD=`pwd`
# USERID=1001
USERID=1000

cp $HOME/.gitconfig .

# podman rmi localhost/rust || true

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;

# https://github.com/containers/podman/issues/24934
# --userns=keep-id:uid=1000,gid=1000 \
# --userns="host"
# --userns-gid-map 1000:1000:1 --userns-uid-map 1000:1000:1
podman \
  build \
  --userns=host \
  -t java-min-alpine -f Containerfile.temurin17.alpine \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/.cargo:/home/vscode/.cargo:z \
  -v $CWD/.rustup:/home/vscode/.rustup:z \
  -v $PNPM_CACHE_DIR:/pnpm:z \
  -v $PIP_CACHE_DIR:/pip:z \
  -v $HF_HOME:/hf:z \
  -v $REALCWD:/build:z;

# -v $HOME/.volta:/home/vscode/.volta:z \
# -v $VOLTA_HOME/tools:/home/vscode/.volta/tools:z \

