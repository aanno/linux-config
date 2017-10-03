# Nextcloud

* https://mariadb.com/kb/en/library/guiworkbench-for-mariadb-aria/

## Nextcloud on docker

* https://github.com/nextcloud/docker (https://hub.docker.com/_/nextcloud/)

## Nextcloud 11

* https://docs.nextcloud.com/server/11/admin_manual/maintenance/backup.html
* https://docs.nextcloud.com/server/11/admin_manual/maintenance/restore.html
* https://docs.nextcloud.com/server/11/admin_manual/issues/general_troubleshooting.html

## Unresolved issues

### First start: DB setup leads to 'SQLSTATE[HY000] [2002] No such file or directory'

Maybe the mariadb connection will be tried the the socket (and hence is 
unavailable in the docker container).

* https://magento.stackexchange.com/questions/51948/sqlstatehy000-2002-no-such-file-or-directory-error
