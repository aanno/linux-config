#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`/../../build-with-docker
REALCWD=`pwd`

#rm -rf ./opt || true
#rm *.gz *.tgz || true
#podman rmi localhost/owntone || true

mkdir -p $CWD/opt/owntone \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;
rm -rf $CWD/opt/owntone/* || true;
# https://github.com/containers/podman/issues/24934
# --userns=keep-id:uid=1000,gid=1000 \
podman build \
  -t ghc -f Containerfile.ghcup.fedora42 \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt/owntone:/opt/owntone:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -v $REALCWD:/build:z \
  -v $HOME/.ghcup:/home/vscode/.ghcup \
  -v $HOME/.stack:/home/vscode/.stack
