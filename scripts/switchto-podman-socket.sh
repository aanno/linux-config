#!/bin/bash -x

systemctl --user stop docker || true
# systemctl --user stop podman.socket || true
systemctl --user restart podman.socket
curl -H "Content-Type: application/json" \
	--unix-socket /run/user/$UID/podman/podman.sock \
    http://localhost/_ping
export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
echo "export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock"
