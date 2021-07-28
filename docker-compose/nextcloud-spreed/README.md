# nextcloud-spreed


## External network

podman network create proxy-tier

/mnt/home/tpasch/.config/cni/net.d/proxy-tier.conflist

$ podman network ls
NETWORK ID    NAME         VERSION     PLUGINS
b932778640d3  cni-podman1  0.4.0       bridge,portmap,firewall,tuning,dnsname
445ee034896e  proxy-tier   0.4.0       bridge,portmap,firewall,tuning,dnsname

## Known problems

* Alpine `libwebsockets` package is compiled without IPv6 support. Without changes,
  this results in `janus-gateway` being without IPv6 support.
  Also see https://pkgs.alpinelinux.org/package/v3.14/main/x86_64/libwebsockets

## References

* https://markus-blog.de/index.php/2020/11/20/how-to-run-nextcloud-talk-high-performance-backend-with-stun-turnserver-on-ubuntu-with-docker-compose/
* https://arnowelzel.de/nextcloud-talk-mit-coturn-und-eigenem-signaling-server

### Testing

* https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/

### github repositories

* https://github.com/strukturag/nextcloud-spreed-signaling
* https://github.com/meetecho/janus-gateway
  + https://janus.conf.meetecho.com/docs/
  + https://github.com/cisco/libsrtp
  + https://github.com/warmcat/libwebsockets
* https://github.com/coturn/coturn
  + https://github.com/coturn/coturn/blob/master/examples/etc/turnserver.conf

### docker repositories

* https://hub.docker.com/repositories
* https://hub.docker.com/_/nats
* https://hub.docker.com/_/alpine
* https://hub.docker.com/r/coturn/coturn

