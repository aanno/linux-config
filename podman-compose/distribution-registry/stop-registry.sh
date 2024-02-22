#!/bin/bash -x

podman stop registry
sleep 10
podman rm -f registry || true
