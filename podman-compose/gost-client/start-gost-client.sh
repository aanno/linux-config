#!/bin/bash -x

. .env
export REMOTE_PROXY="${REMOTE_PROXY_HOST}:${REMOTE_PROXY_PORT}"
export REMOTE_SOCKS="${REMOTE_SOCKS_HOST}:${REMOTE_SOCKS_PORT}"
envsubst <config/gost-subst.yml >config/gost.yml

podman-compose down
podman-compose  up -d
podman-compose logs -f
