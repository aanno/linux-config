#!/bin/bash -x 

export VERSION="v2.5.0"
export IMAGE="docker.io/aanno/certbot-netcup:$VERSION"

envsubst <Dockerfile.envsub >Dockerfile

# buildah pull "$IMAGE"
# buildah bud -t "$IMAGE" .
# buildah push "$IMAGE"

# podman pull "$IMAGE"
podman build -t "$IMAGE" .
podman push "$IMAGE"

