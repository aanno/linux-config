#!/bin/bash -x

if [ -z $DOCKER ]; then
  export DOCKER=podman
fi

. .env
REMOTE_PROXY="${REMOTE_PROXY_HOST}:${REMOTE_PROXY_PORT}"
REMOTE_SOCKS="${REMOTE_SOCKS_HOST}:${REMOTE_SOCKS_PORT}"
export REMOTE_PROXY REMOTE_SOCKS REMOTE_PROXY_USER REMOTE_PROXY_PW
envsubst <config/gost-subst.yml >config/gost.yml

# for the time ghost proxy is there, disable ipv6
# as proxy is ipv4 only (and there is no way to get ipv6 over it)
# see https://www.cyberciti.biz/faq/how-to-temporarily-disable-ipv6-in-linux/
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

$DOCKER compose down
$DOCKER compose up -d

$DOCKER compose logs -f
