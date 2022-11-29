#!/bin/bash -x

cat db.env | sed -e 's/^/export /' >db-export.env
source db-export.env
envsubst <db/create.in.sql >db/create.sql 

# https://stackoverflow.com/questions/34779894/executing-sql-scripts-on-docker-container
podman cp db/create.sql ${WORDPRESS_DB_HOST}:/
podman exec ${WORDPRESS_DB_HOST} sh -c 'mysql -u root --password=$MYSQL_ROOT_PASSWORD -B </create.sql'

echo "mysql returns: $?"

# rm db-export.env db/create.sql
