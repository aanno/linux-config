#!/bin/bash -x

# set -xe
set -euo pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD="$GIT_ROOT/build-with-docker"
MYCWD="$GIT_ROOT/build-rpms-on-podman"

mkdir -p "$MYCWD/src"

pushd "$GIT_ROOT/build-rpms-on-podman"

podman run --rm -it \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt:/opt:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -v $MYCWD/src:/src:z \
  docker.io/library/fedora:44 bash;

popd
