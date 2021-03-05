#!/bin/bash -x 

export VERSION="v1.13.0"
export IMAGE="docker.io/aanno/certbot-netcup:$VERSION"

envsubst <Dockerfile.envsub >Dockerfile
buildah bud -t "$IMAGE" .
podman push "$IMAGE"
