#!/bin/bash -x

set -xe

GIT_ROOT=`git rev-parse --show-toplevel`

pushd "$GIT_ROOT/docker-compose/nextcloud-spreed"

source "scripts/env.sh"

rm docker-compose.yml server.conf || true
envsubst <docker-compose.in.yml >docker-compose.yml
envsubst <server.in.conf >server.conf
podman-compose -p spreed -t identity --podman-run-args='--net proxy-tier' up docker-compose.yml 

popd
