#!/bin/bash -x

podman-compose down
podman-compose pull
podman-compose run --name flink --rm sql-client
