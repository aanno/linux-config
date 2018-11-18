#!/bin/bash -x

./dnc-compose.sh exec --user www-data nextcloud_container php /var/www/html/nextcloud/occ $*

