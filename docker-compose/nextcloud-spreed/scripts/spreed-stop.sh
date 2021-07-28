#!/bin/bash -x

set -xe

GIT_ROOT=`git rev-parse --show-toplevel`

pushd "$GIT_ROOT/docker-compose/nextcloud-spreed"

source "scripts/env.sh"
exec podman-compose -p spreed down

popd
