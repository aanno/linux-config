#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`/../../build-with-docker

# curl -o ghcup.sh --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org
# curl -o stack.sh -sSL https://get.haskellstack.org/
if [ ! -f mvn.zip ]; then
  curl -o mvn.zip -sSL https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip
  curl -o mvn.zip.sha512 -sSL https://downloads.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip.sha512
  echo " mvn.zip" >> mvn.zip.sha512
fi
if sha512sum -c mvn.zip.sha512; then
  echo "Maven download verified"
else
  echo "Maven download corrupted"
  rm mvn.zip mvn.zip.sha512
  exit 1
fi

