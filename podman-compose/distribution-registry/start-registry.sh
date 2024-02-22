#!/bin/bash -x

podman rm -f registry || true
podman run -d -p 5000:5000 --restart=always --name registry \
             -v ./config.yml:/etc/docker/registry/config.yml:z,ro \
             -v ./htpasswd:/etc/docker/registry/htpasswd:z,ro \
             -v ./data:/var/lib/registry:z \
             registry:2
podman logs -f registry
