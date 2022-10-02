#!/bin/bash -x

set -xe

GIT_ROOT=`git rev-parse --show-toplevel`

pushd "$GIT_ROOT/docker-compose/nextcloud-spreed"

source "scripts/env.sh"

rm coturn-only-compose.yml server.conf || true
envsubst <coturn-only-compose.in.yml >coturn-only-compose.yml
envsubst <server.in.conf >server.conf
podman-compose -p spreed -t identity --podman-run-args='--net proxy-tier' \
  -f coturn-only-compose.yml up # -d

popd
