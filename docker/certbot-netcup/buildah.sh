#!/bin/bash -x 

export VERSION="v1.13.0"
export IMAGE="docker.io/aanno/certbot-netcup:$VERSION"

envsubst <Dockerfile.envsub >Dockerfile

buildah pull "$IMAGE"
buildah bud -t "$IMAGE" .
buildah push "$IMAGE"
