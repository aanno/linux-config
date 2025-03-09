#!/bin/bash -x

. .env
REMOTE_PROXY="${REMOTE_PROXY_HOST}:${REMOTE_PROXY_PORT}"
REMOTE_SOCKS="${REMOTE_SOCKS_HOST}:${REMOTE_SOCKS_PORT}"
export REMOTE_PROXY REMOTE_SOCKS REMOTE_PROXY_PORT REMOTE_SOCKS_PORT \
  REMOTE_PROXY_USER1 REMOTE_PROXY_PW1 \
  REMOTE_PROXY_USER2 REMOTE_PROXY_PW2 \
  REMOTE_PROXY_USER3 REMOTE_PROXY_PW3
envsubst <config/gost-subst.yml >config/gost.yml

podman-compose down
podman-compose up -d

sleep 2
# test
curl -v --proxy-user ${REMOTE_PROXY_USER1}:${REMOTE_PROXY_PW1} --proxy "http://${REMOTE_PROXY}" https://www.google.de
curl -v --proxy-user ${REMOTE_PROXY_USER1}:${REMOTE_PROXY_PW1} --proxy "socks5h://${REMOTE_SOCKS}" https://www.google.de
# curl -v --proxy-user ${REMOTE_PROXY_USER1}:${REMOTE_PROXY_PW1} --socks5 "http://${REMOTE_SOCKS}" https://www.google.de
curl -v --proxy-user ${REMOTE_PROXY_USER1}:${REMOTE_PROXY_PW1} --socks5-hostname "${REMOTE_SOCKS}" https://www.google.de

echo podman-compose logs -f
