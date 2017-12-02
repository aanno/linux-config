# Nextcloud

* https://mariadb.com/kb/en/library/guiworkbench-for-mariadb-aria/

## Nextcloud on docker

* https://github.com/nextcloud/docker (https://hub.docker.com/_/nextcloud/)

## Nextcloud 11

* https://docs.nextcloud.com/server/11/admin_manual/maintenance/backup.html
* https://docs.nextcloud.com/server/11/admin_manual/maintenance/restore.html
* https://docs.nextcloud.com/server/11/admin_manual/issues/general_troubleshooting.html

## Nextcloud 12

* https://docs.nextcloud.com/server/12/admin_manual/configuration_server/config_sample_php_parameters.html
* https://docs.nextcloud.com/server/12/admin_manual/installation/nginx.html
* https://docs.nextcloud.com/server/12/admin_manual/configuration_server/reverse_proxy_configuration.html
* https://docs.nextcloud.com/server/12/admin_manual/configuration_server/caching_configuration.html

### Installation manuals

* https://kopfkrieg.org/2017/06/15/nextcloud-docker-nginx/
* https://bayton.org/docs/nextcloud/installing-nextcloud-on-ubuntu-16-04-lts-with-redis-apcu-ssl-apache/

## Additional software

* https://nextcloud.com/collaboraonline/ <br/>
  **online office** for nextcloud
  + https://help.nextcloud.com/t/start-to-finish-nextcloud-collabora-step-by-step-guide/10602
  + Docker image: https://hub.docker.com/r/collabora/code/
  + Setup (with reverse proxy): https://www.collaboraoffice.com/code/
* Nextant: Solr full text search https://github.com/nextcloud/nextant
  + https://github.com/nextcloud/nextant/wiki/Extracting,-Live-Update
  + Solr
    - https://github.com/nextcloud/nextant/wiki/Setup-your-local-Solr-as-a-Service
    - Solr docker image: https://hub.docker.com/_/solr/
* Spreed.ME WebRTC conference server
  + https://github.com/strukturag/nextcloud-spreedme/blob/master/README.md

## Unresolved issues

### First start: DB setup leads to 'SQLSTATE[HY000] [2002] No such file or directory'

Maybe the mariadb connection will be tried the the socket (and hence is 
unavailable in the docker container).

* https://magento.stackexchange.com/questions/51948/sqlstatehy000-2002-no-such-file-or-directory-error
