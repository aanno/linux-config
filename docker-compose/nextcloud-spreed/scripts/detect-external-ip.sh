#!/bin/bash -x

podman run --rm --entrypoint detect-external-ip coturn/coturn $*

