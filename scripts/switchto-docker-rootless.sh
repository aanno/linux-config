#!/bin/bash -x

systemctl --user stop podman.socket || true
systemctl --user start docker
curl -H "Content-Type: application/json" \
	--unix-socket /run/user/$UID/docker.sock \
    http://localhost/_ping
export DOCKER_HOST=unix:///run/user/$UID/docker.sock
echo "export DOCKER_HOST=unix:///run/user/$UID/docker.sock"
