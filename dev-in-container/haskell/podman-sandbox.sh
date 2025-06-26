#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
# CWD=`pwd`/../../build-with-docker
# TODO
CWD=/var/home/tpasch/scm/linux-config/build-with-docker
REALCWD=`pwd`

#rm -rf ./opt || true
#rm *.gz *.tgz || true
#podman rmi localhost/owntone || true

mkdir -p \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;
# rm -rf $CWD/opt/owntone/* || true;
podman run --rm -it \
  --userns=keep-id:uid=1000,gid=1000 \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt/owntone:/opt/owntone:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -v $HOME/.ghcup:/home/vscode/.ghcup:z \
  -v $HOME/.stack:/home/vscode/.stack:z \
  -v $HOME/.cabal:/home/vscode/.cabal:z \
  -v $REALCWD:/workspaces/ghc:z \
  localhost/ghc \
  /bin/bash;

  # registry.fedoraproject.org/fedora:42 \
