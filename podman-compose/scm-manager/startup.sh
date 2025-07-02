#!/bin/bash -x

podman rm -f scm-manager
podman rmi -f docker.io/library/scm-manager-scm-manager
podman build -t localhost/scm-manager .
podman compose up -d
podman logs -f scm-manager
