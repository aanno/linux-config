#!/bin/bash -x 

export VERSION="v3.2.0"
export ARCH=`uname -m`
export IMAGE_VERSION="${VERSION}-${ARCH}"
export IMAGE="docker.io/aanno/certbot-netcup:$IMAGE_VERSION"

envsubst <Dockerfile.envsub >Dockerfile

# buildah pull "$IMAGE"
# buildah bud -t "$IMAGE" .
# buildah push "$IMAGE"

# podman pull "$IMAGE"
podman build -t "$IMAGE" .
podman push "$IMAGE"

