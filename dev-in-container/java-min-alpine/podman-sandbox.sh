#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
CWD=/home/tpasch/scm/aanno/github/linux-config/build-with-docker
REALCWD=`pwd`
# USERID=1001
USERID=1000

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;

podman run --rm -it \
  --userns=keep-id:uid=$USERID,gid=$USERID \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/.cargo:/home/vscode/.cargo:z \
  -v $CWD/.rustup:/home/vscode/.rustup:z \
  -v $PNPM_CACHE_DIR:/pnpm:z \
  -v $PIP_CACHE_DIR:/pip:z \
  -v $PNPM_CACHE_DIR:/home/vscode/.local/share/pnpm/store/v10:z \
  -v $MVN_LOCAL_REPO:/home/vscode/.m2/repository:z \
  -v $GRADLE_USER_HOME:/home/vscode/.gradle:z \
  -v $NPM_CACHE_DIR:/home/vscode/.npm:z \
  -v $HF_HOME:/hf:z \
  -v $REALCWD:/build:z \
  localhost/java-min-alpine \
  /bin/sh;

# -v $HOME/.volta:/home/vscode/.volta:z \
# registry.fedoraproject.org/fedora:42 \
# -v $VOLTA_HOME/tools:/home/vscode/.volta/tools:z \

