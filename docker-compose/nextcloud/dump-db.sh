#!/bin/bash -x

# https://docs.nextcloud.com/server/12/admin_manual/maintenance/backup.html
mysqldump \
  --defaults-file="/tmp/tmpMC439k/extraparams.cnf"  \
  --user=root --host=localhost --protocol=tcp --port=3306 \
  --default-character-set=utf8mb4 --single-transaction=TRUE \
  --skip-triggers \
  "cloud"
