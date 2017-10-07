#!/bin/bash -x
# https://github.com/nextcloud/docker


BASE="/home/dockeruser/nctest"
TARGET="/var/www/html"
VERSION="11.0.5"

docker run -d \
  --network="host" \
  -v "$BASE/apps:$TARGET/custom_apps" \
  -v "$BASE/config:$TARGET/config" \
  -v "$BASE/data:$TARGET/data" \
  "nextcloud:$VERSION"

# --network="bridge" \
# -p 8080:80 \

