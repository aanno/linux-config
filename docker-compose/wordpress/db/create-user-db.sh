#!/bin/bash -x

source "../db.env"
cat db.env | sed -e 's/^/export /' >db-export.env
source "db-export.env"
echo "WORDPRESS_DB_HOST is $WORDPRESS_DB_HOST"

envsubst <create.in.sql >create.sql
cat create.sql

# https://stackoverflow.com/questions/34779894/executing-sql-scripts-on-docker-container
podman cp create.sql ${WORDPRESS_DB_HOST}:/
podman exec ${WORDPRESS_DB_HOST} sh -c 'mysql -u root --password=$MYSQL_ROOT_PASSWORD -B </create.sql'

echo "mysql returns: $?"

# rm db-export.env db/create.sql
