#!/bin/bash -x
# https://github.com/nextcloud/docker


# export BASE="/home/dockeruser/nextcloud"
export BASE="/home/dockeruser/keycloak"
# not used 
export BASE_PATH="/keycloak"

if [ -z $KEYCLOAK_DB_PASSWORD ]; then
  echo "KEYCLOAK_DB_PASSWORD not set"
  exit -1
fi

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

