#!/bin/bash -x
# https://github.com/nextcloud/docker


# export BASE="/home/dockeruser/nextcloud"
export BASE="."
export BASE_PATH="/keycloak"

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

