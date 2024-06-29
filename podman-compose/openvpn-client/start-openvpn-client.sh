#!/bin/bash -x
podman-compose down
podman-compose up -d
podman-compose logs -f
