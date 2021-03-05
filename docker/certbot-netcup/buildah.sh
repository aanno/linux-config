#!/bin/bash -x 

export VERSION="v1.13.0"

envsubst <Dockerfile.envsub >Dockerfile
buildah bud -t docker.io/aanno/certbot-netcup:$VERSION .
