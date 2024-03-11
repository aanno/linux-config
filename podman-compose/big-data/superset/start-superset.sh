#!/bin/bash -x
# https://superset.apache.org/docs/installation/installing-superset-using-docker-compose/

podman-compose -f docker-compose-non-dev.yml down
podman-compose -f docker-compose-non-dev.yml pull
podman-compose -p superset -f docker-compose-non-dev.yml up
