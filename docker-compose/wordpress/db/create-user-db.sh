#!/bin/bash -x

cat db.env | sed -e 's/^/export /' >db-export.env
source db-export.env
envsubst <create.in.sql >create.sql 

# https://stackoverflow.com/questions/34779894/executing-sql-scripts-on-docker-container
docker cp create.sql db-db-1:/
docker exec db-db-1 sh -c 'mysql -u root --password=$MYSQL_ROOT_PASSWORD -B </create.sql'

echo "mysql returns: $?"

rm db-export.env create.sql
