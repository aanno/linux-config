#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
# TODO
CWD=/var/home/tpasch/scm/linux-config/build-with-docker
REALCWD=`pwd`
USERID=1001

cp $HOME/.gitconfig .
cp $HOME/.cabal/config .
cp $HOME/.stack/config.yaml .

#rm -rf ./opt || true
#rm *.gz *.tgz || true
#podman rmi localhost/owntone || true

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;
# rm -rf $CWD/opt/owntone/* || true;
# https://github.com/containers/podman/issues/24934
# --userns=keep-id:uid=1000,gid=1000 \
podman build \
  -t ghc -f Containerfile.ghcup.fedora42 \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -v $REALCWD:/build:z \
  -v $HOME/.ghcup:/home/vscode/.ghcup:z \
  -v $HOME/.stack:/home/vscode/.stack:z \
  -v $HOME/.cabal:/home/vscode/.cabal:z \
  -v $REALCWD/config.yaml:/home/vscode/.stack/config.yaml:z \
  -v $REALCWD/cabal/config:/home/vscode/.cabal/config:z \
  -v $REALCWD/ghcup/env:/home/vscode/.ghcup/env:z



