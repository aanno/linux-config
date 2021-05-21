#!/bin/bash -x

set -xe

./spotifyd --no-daemon --verbose --bitrate 320 \
  --device-type computer --device-name redsnapper-spotifyd \
  -u aannoaanno@gmail.com -p 2malAanno
