#!/bin/bash -x
# https://github.com/nextcloud/docker


export BASE="/home/dockeruser/nctest"
export BASE_PATH="/nextcloud"
export TARGET="/var/www/html${BASE_PATH}"
export VERSION="11.0.5"
export DOMAIN="breitbandig.de,www.breitbandig.de,mail.breitbandig.de,netzgeneration.com,www.netzgeneration.com,mail.netzgeneration.com,v22017092131153710.goodsrv.de"
export EMAIL="aannoaanno@gmail.com"

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ -z "$1" ]; then
  COMMAND="up"
else 
  COMMAND="$1"
fi
shift

pushd $DIR
  docker-compose "$COMMAND" $*
popd
