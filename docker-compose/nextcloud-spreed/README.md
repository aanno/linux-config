# nextcloud-spreed

Before everything else, `mv scripts/env.sh.template scripts/env.sh` and adapt it to your needs!

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
* 'external networks' are _not_ honoured by `podman-compose` but maybe 
  https://github.com/containers/podman-compose/issues/283 could fix that

## References

* https://markus-blog.de/index.php/2020/11/20/how-to-run-nextcloud-talk-high-performance-backend-with-stun-turnserver-on-ubuntu-with-docker-compose/
* https://arnowelzel.de/nextcloud-talk-mit-coturn-und-eigenem-signaling-server

### Testing

* https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/
* nextcloud-spreed-signaling
  + `curl -k -v -i https://signaling.breitbandig.local:8443/nextcloud/signaling/api/v1/welcome`
  + `wget -v --no-check-certificate https://signaling.breitbandig.local:8443/nextcloud/signaling/api/v1/welcome`
  + _from inside the `nc_app_1` container the following works: _<br/>
    `curl -k -v -i http://spreed_spreedbackend_1:8080/api/v1/welcome`

### github repositories

* https://github.com/strukturag/nextcloud-spreed-signaling
  + https://github.com/strukturag/nextcloud-spreed-signaling/blob/master/server.conf.in
* https://github.com/meetecho/janus-gateway
  + https://janus.conf.meetecho.com/docs/
  + https://github.com/cisco/libsrtp
  + https://github.com/warmcat/libwebsockets
* https://github.com/coturn/coturn
  + https://github.com/coturn/coturn/blob/master/examples/etc/turnserver.conf
  + https://github.com/coturn/coturn/wiki/turnserver

### docker repositories

* https://hub.docker.com/repositories
* https://hub.docker.com/_/nats
* https://hub.docker.com/_/alpine
* https://hub.docker.com/r/coturn/coturn
