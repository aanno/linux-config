#!/bin/bash -x

systemctl --user stop podman.socket || true
# systemctl --user stop docker || true
systemctl --user restart docker
curl -H "Content-Type: application/json" \
	--unix-socket /run/user/$UID/docker.sock \
    http://localhost/_ping
export DOCKER_SOCKET=/run/user/$UID/docker.sock
export DOCKER_HOST=unix://$DOCKER_SOCKET
echo "export DOCKER_SOCKET=$DOCKER_SOCKET"
echo "export DOCKER_HOST=$DOCKER_HOST"

