# Docker

## Books

* https://dockerbook.com/

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
* `docker-compose.yml` https://docs.docker.com/compose/compose-file/#labels-3
* `docker-compose up` https://docs.docker.com/compose/reference/up/

## Additional software

* https://hub.docker.com/r/jwilder/docker-gen/ (https://github.com/jwilder/docker-gen) <br/>
  Updating (other) container configuration files based on (other) container 
  lifecycle
* (https://github.com/jwilder/nginx-proxy) <br/>
  **nginx reverse proxy** for mapping virtual hosts to (other) container and TLS 
  unpacking (let's encrypt)
  + https://hub.docker.com/r/jrcs/letsencrypt-nginx-proxy-companion/ 
    (https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) <br />
    let's encrypt for nginx proxy
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

## Docker on Windows

* https://docs.microsoft.com/de-de/virtualization/windowscontainers/quick-start/quick-start-windows-10

## Docker-in-Docker

* https://github.com/moby/moby/wiki/Docker-in-Docker

### Contra

* https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
* https://www.develves.net/blogs/asd/2016-05-27-alternative-to-docker-in-docker/

## Docker Swarm

* https://docs.docker.com/engine/swarm/
  + https://docs.docker.com/engine/swarm/swarm-tutorial/
  + https://github.com/docker/swarmkit
  + https://github.com/docker/swarm
