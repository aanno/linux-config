#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`/../../build-with-docker

curl -o ghcup.sh --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org
curl -o stack.sh -sSL https://get.haskellstack.org/
