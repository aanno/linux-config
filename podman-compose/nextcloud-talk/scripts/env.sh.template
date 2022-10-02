#!/bin/bash -x

# Attention: This file is normally _sourced_!

export GIT_ROOT=`git rev-parse --show-toplevel`

# ip address of server host (needed for TURN/STUN)
export SERVER_EXTERNAL_IP="192.168.10.20"
# fqn server (needed for coturn and url of spreed signaling)
export SERVER_FQN="signaling.example.com"
# port of turn on SERVER_EXTERNAL_IP
export TURN_PORT=3478

# `--static-auth-secret` of `coturn`
# openssl rand -hex 32
export COTURN_SECRET="1e95cf79ccaf812f2498c4a2470a6dd5e62eeb2451d34e819ea12602b8d1bf67"
# `--realm` of `coturn`
export COTURN_FQN="${SERVER_FQN}"

# only one backend
export SIGNALING_BACKEND_URL="https://${SERVER_FQN}"
# openssl rand -hex 16
export SIGNALING_BACKEND_SECRET="a39fa4d0b1580307ea0f9f23e8c36832"

# openssl rand -base64 48
export SIGNALING_HASHKEY="iytgESfwDySTGcJEbjwcjqYgRnE1ynaDyHv6KhWzqTT6zePJTfqhBLBlyCNvj0HO"
# openssl rand -base64 16
export SIGNALING_BLOCKKEY="tnj3Q3xrw3TmCaJRslVyGQ=="

# openssl rand -base64 16
export SIGNALING_TURN_APIKEY="yCt808b4fxnoGaDKlsAp8w=="
export SIGNALING_TURN_SECRET="${COTURN_SECRET}"

