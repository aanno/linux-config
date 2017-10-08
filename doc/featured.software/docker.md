# Docker

## Commands

### `docker network create`

* https://docs.docker.com/engine/userguide/networking/work-with-networks/
* https://docs.docker.com/engine/reference/commandline/network_create/

### `docker run` (with expose)

* https://docs.docker.com/engine/reference/run/

### `dockerd`

* https://docs.docker.com/engine/reference/commandline/dockerd/

## Docker environment

### `docker-compose`

* https://docs.docker.com/compose/gettingstarted/

## Additional software

* https://hub.docker.com/r/jwilder/docker-gen/ (https://github.com/jwilder/docker-gen) <br/>
  Updating (other) container configuration files based on (other) container 
  lifecycle
* (https://github.com/jwilder/nginx-proxy) <br/>
  **nginx reverse proxy** for mapping virtual hosts to (other) container and TLS 
  unpacking (let's encrypt)
  + https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/
  + https://blog.florianlopes.io/host-multiple-websites-on-single-host-docker/
* https://hub.docker.com/_/nextcloud/ (https://github.com/nextcloud/docker) <br/>
  **nextcloud** as docker container
  + https://github.com/nextcloud/docker/tree/master/.examples
  + Using **traefik** with nextcloud-docker <br/>
    (https://github.com/Orybon/nextcloud-docker-compose/blob/master/docker-compose.yml) <br/>
    (https://github.com/nextcloud/docker/issues/155)
  + Why it is impossible to use NEXTCLOUD_CONFIG_DIR <br/>
    (https://github.com/nextcloud/docker/issues/102)
  + Alternative docker image, redis, APCu, and nextant configuration
    - https://hub.docker.com/r/wonderfall/nextcloud/
* Alpine Linux https://alpinelinux.org/about/
  + Minimal linux, a base for many docker images
* `dnsmasq` for DNS lookup speedup
  + https://opsech.io/posts/2017/May/23/docker-dns-with-firewalld-on-fedora.html
  + https://opsech.io/posts/2016/Feb/14/quick-tip-enable-easy-networkmanager-local-dns-caching.html
