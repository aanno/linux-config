# podman-compose

* https://github.com/profihost/podman-container-configs

## let's encrypt

* https://forum.netcup.de/netcup-intern/technik/11841-let-s-encrypt-wildcard-zertifikate-via-certbot/

### linuxserver/docker-swag

* https://github.com/linuxserver/docker-swag
  + https://docs.linuxserver.io/general/swag
* https://docs.linuxserver.io/
  + https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/

### acme.sh

* https://de.wikipedia.org/wiki/Automatic_Certificate_Management_Environment
* https://github.com/acmesh-official/acme.sh
* https://hub.docker.com/r/neilpang/acme.sh
* https://github.com/acmesh-official/acme.sh/wiki/dnsapi#51-use-netcup-dns-api-to-automatically-issue-cert

### certbot

* https://certbot.eff.org/docs/using.html#getting-certificates-and-choosing-plugins
* https://github.com/pierreprinetti/certbot (docker)
* https://github.com/coldfix/certbot-dns-netcup

## podman gotchas

* https://www.redhat.com/sysadmin/rootless-podman-makes-sense (recommended)
* https://www.redhat.com/sysadmin/user-namespaces-selinux-rootless-containers
* https://www.redhat.com/sysadmin/container-networking-podman
* https://fedoramagazine.org/podman-with-capabilities-on-fedora/
* https://ask.fedoraproject.org/t/podman-and-volume-permission-denied/6221/2
* https://opensource.com/article/19/5/shortcomings-rootless-containers
* https://www.niels.fr/blog/rootless-container-with-systemd/
* https://github.com/containers/podman/issues/6884
* https://archive.fosdem.org/2020/schedule/event/security_using_selinux_with_container_runtimes/attachments/slides/4154/export/events/attachments/security_using_selinux_with_container_runtimes/slides/4154/Fosdem_Using_SELinux_with_container_runtimes.pdf (has all the details)

## mysql backup

```sh
/usr/libexec/mysql-workbench/mysqldump --defaults-file="/tmp/tmpXX8fmH/extraparams.cnf"  --user=root --host=localhost --protocol=tcp --port=40177 --default-character-set=utf8 --routines --single-transaction=TRUE --databases "gitbucket" "cloud" "keycloak"
```

* [mysqldump](https://mariadb.com/kb/en/mysqldump/)
  + [backups with mysqldump](https://mariadb.com/kb/en/making-backups-with-mysqldump/)
* [mysqlcheck](https://mariadb.com/kb/en/mysqlcheck/)
