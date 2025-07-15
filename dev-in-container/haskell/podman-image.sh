#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
CWD=/home/tpasch/dev/scm/aanno/github/linux-config/build-with-docker
REALCWD=`pwd`
# USERID=1001
USERID=1000
# GHCHOME=$HOME
# .ghcup .stack .cabal are placed special here
GHCHOME=/stratis/home/tpasch/dev

cp $HOME/.gitconfig .
cp $GHCHOME/.cabal/config .
cp $GHCHOME/.stack/config.yaml .

#podman rmi localhost/ghc || true

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;

# https://github.com/containers/podman/issues/24934
# --userns=keep-id:uid=1000,gid=1000 \
podman build \
  -t ghc -f Containerfile.ghcup.fedora42 \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $PNPM_CACHE_DIR:/pnpm:z \
  -v $PIP_CACHE_DIR:/pip:z \
  -v $VOLTA_HOME/tools:/home/vscode/.volta/tools:z \
  -v $REALCWD:/build:z \
  -v $GHCHOME/.ghcup:/home/vscode/.ghcup:z \
  -v $GHCHOME/.stack:/home/vscode/.stack:z \
  -v $GHCHOME/.cabal:/home/vscode/.cabal:z \
  -v $REALCWD/config.yaml:/home/vscode/.stack/config.yaml:z \
  -v $REALCWD/cabal/config:/home/vscode/.cabal/config:z \
  -v $REALCWD/ghcup/env:/home/vscode/.ghcup/env:z

  # -v $CWD/.cargo:/root/.cargo:z \
  # -v $CWD/.rustup:/root/.rustup:z \


