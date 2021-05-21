#!/bin/bash -x

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container

podman run -v /var/run/avahi-daemon/socket:/var/run/avahi-daemon/socket:z \
  -v /var/run/dbus:/var/run/dbus:z \
  --network=host --rm -it $1 bash
