# Nextcloud all-in-one on Fcos

## Nextcloud

## NC aio

* [NC aio on github](https://github.com/nextcloud/all-in-one)
  + https://github.com/nextcloud/all-in-one/blob/main/compose.yaml
  + [commercial aio](https://nextcloud.com/all-in-one/)
* [Nextcloud AppAPI](https://github.com/nextcloud/app_api)

### aio gotchas

* disable SELinux with `security_opt: ["label:disable"]`
* there might be problems with firewalld (switch backend to iptables)
* [ipv6 support](https://github.com/nextcloud/all-in-one/blob/main/docker-ipv6-support.md)
* multiple domains are _not_ supported, perhaps this helps:
  + [multiple instances](https://github.com/nextcloud/all-in-one/blob/main/multiple-instances.md)
* [local instance](https://github.com/nextcloud/all-in-one/blob/main/local-instance.md)
* [nextcloud's trusted provider (VPS)](https://nextcloud.com/providers/)

* [manual install (several compose containers) vs. real aio](https://github.com/nextcloud/all-in-one/tree/main/manual-install)
* [docker rootless](https://github.com/nextcloud/all-in-one/blob/main/docker-rootless.md)
* [reverse proxy](https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md)

### advanced aio configuration

* [community-containers](https://github.com/nextcloud/all-in-one/tree/main/community-containers)
* [Nextcloud AppAPI](https://github.com/nextcloud/app_api)
* [hardening with fail2ban](https://docs.nextcloud.com/server/stable/admin_manual/installation/harden_server.html#setup-fail2ban)

## nextcloud migration

* [Nextcloud Datenbankmigration von MariaDB zu PostgreSQL](https://www.c-rieger.de/nextcloud-datenbankmigration-von-mariadb-zu-postgresql/)
