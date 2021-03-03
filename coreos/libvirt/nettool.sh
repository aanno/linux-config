#!/bin/bash -x

# CONTAINER=`podman run --net slirp4netns:allow_host_loopback=true,enable_ipv6=true,outbound_addr6=fd68:fd2c:b38:40ab::56ab --env HTTP_PORT=8081 --env HTTPS_PORT=8082 -d praqma/network-multitool`
# CONTAINER=`podman run --net slirp4netns:allow_host_loopback=true,enable_ipv6=true,outbound_addr6=2001:470:26:ba5:4049:b055:c122:40ab --env HTTP_PORT=8081 --env HTTPS_PORT=8082 -d praqma/network-multitool`
# --cap-add NET_ADMIN
CONTAINER=`podman run --net slirp4netns:allow_host_loopback=true,enable_ipv6=true --env HTTP_PORT=8081 --env HTTPS_PORT=8082 -p 8081:8081 -p 8082:8082 -d praqma/network-multitool`
podman exec -it $CONTAINER bash
podman rm -f $CONTAINER

