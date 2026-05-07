#!/bin/bash -x

export APP=pwvucontrol
export DIST=f44
export IMAGE=localhost/${APP}:${DIST}

set -euo pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD="$GIT_ROOT/build-with-docker"
MYCWD="$GIT_ROOT/build-rpms-on-podman"

rm -rf ./src/$APP/builddir/usr || true
rm *.gz *.tgz src/*.gz src/*.tgz || true
podman rmi $IMAGE || true

mkdir -p $CWD/opt/owntone \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;

podman build --pull -t $IMAGE \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt:/opt:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -v $MYCWD/src:/src:z \
  -f Containerfile.pwvucontrol.fedora44;
