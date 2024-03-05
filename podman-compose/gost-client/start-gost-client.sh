#!/bin/bash -x

. .env
REMOTE_PROXY="${REMOTE_PROXY_HOST}:${REMOTE_PROXY_PORT}"
REMOTE_SOCKS="${REMOTE_SOCKS_HOST}:${REMOTE_SOCKS_PORT}"
export REMOTE_PROXY REMOTE_SOCKS REMOTE_PROXY_USER REMOTE_PROXY_PW
envsubst <config/gost-subst.yml >config/gost.yml

podman-compose down
podman-compose up -d

sleep 2
# test
curl --proxy-user ${REMOTE_PROXY_USER}:${REMOTE_PROXY_PW} --proxy "http://localhost:8080" https://www.google.de
curl --proxy-user ${REMOTE_PROXY_USER}:${REMOTE_PROXY_PW} --socks5 "http://localhost:1080" https://www.google.de

podman-compose logs -f
