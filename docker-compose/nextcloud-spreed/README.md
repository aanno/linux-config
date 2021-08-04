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

## TURN/coturn

* docker images:
  + https://github.com/strukturag/docker-webrtc-turnserver
  + https://github.com/Monogramm/docker-coturn
  + https://github.com/coturn/coturn original image, maybe difficult to use:
    - https://github.com/coturn/coturn/issues/492 (socket: Protocol not supported)

## References

* https://markus-blog.de/index.php/2020/11/20/how-to-run-nextcloud-talk-high-performance-backend-with-stun-turnserver-on-ubuntu-with-docker-compose/
* https://arnowelzel.de/nextcloud-talk-mit-coturn-und-eigenem-signaling-server

## TODO

* check if `docker-compose.in.yml` is really needed as `podman-compose` interpolates
  environment variables
* check IPv6 support (it is missing with `janus-gateway` and unconfigured in `coturn`)
* `coturn` config will only work on public IP (not behind firewall) (perhaps with could be
  fixed)

### Testing

#### Testing `nextcloud-spreed-signaling`

* nextcloud-spreed-signaling
  + `curl -k -v -i https://signaling.breitbandig.local:8443/nextcloud/signaling/api/v1/welcome`
  + `wget -v --no-check-certificate https://signaling.breitbandig.local:8443/nextcloud/signaling/api/v1/welcome`
  + _from inside the `nc_app_1` container the following works: _<br/>
    `curl -k -v -i http://spreed_spreedbackend_1:8080/api/v1/welcome`

#### Testing TURN/coturn

* https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/
* https://stackoverflow.com/questions/44996545/why-my-turn-server-doesnt-work
* https://github.com/coturn/coturn/issues/745
* https://manpages.debian.org/testing/coturn/turnutils.1.en.html <br/>
  `turnutils_uclient -v -P -p 3478 -w 1e95cf79ccaf812f2498c4a2470a6dd5e62eeb2451d34e819ea12602b8d1bf67 signaling.breitbandig.local`
* https://stackoverflow.com/questions/34030188/easy-way-to-test-turn-server

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
