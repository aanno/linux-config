#!/bin/bash -x

. .env
REMOTE_PROXY="${REMOTE_PROXY_HOST}:${REMOTE_PROXY_PORT}"
REMOTE_SOCKS="${REMOTE_SOCKS_HOST}:${REMOTE_SOCKS_PORT}"
export REMOTE_PROXY REMOTE_SOCKS REMOTE_PROXY_USER REMOTE_PROXY_PW
envsubst <config/gost-subst.yml >config/gost.yml

gost -C config/gost.yml
