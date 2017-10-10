#!/bin/bash -x

./dnc-compose.sh exec --user www-data app php /var/www/html/nextcloud/occ $*

