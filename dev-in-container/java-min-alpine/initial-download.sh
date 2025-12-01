#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`/../../build-with-docker

# mvn
if [ ! -f mvn.zip ]; then
  curl -o mvn.zip -sSL https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip
  curl -o mvn.zip.sha512 -sSL https://downloads.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.zip.sha512
  echo " mvn.zip" >> mvn.zip.sha512
fi

# https://services.gradle.org/distributions/gradle-9.2.1-bin.zip
# gradle
if [ ! -f gradle.zip ]; then
  curl -o gradle.zip -sSL https://services.gradle.org/distributions/gradle-9.2.1-bin.zip
  curl -o gradle.zip.sha256 -sSL https://services.gradle.org/distributions/gradle-9.2.1-bin.zip.sha256
  echo " gradle.zip" >> gradle.zip.sha256
fi

if sha512sum -c mvn.zip.sha512; then
  echo "Maven download verified"
else
  echo "Maven download corrupted"
  rm mvn.zip mvn.zip.sha512
  exit 1
fi

if sha256sum -c gradle.zip.sha256; then
  echo "Gradle download verified"
else
  echo "Gradle download corrupted"
  rm gradle.zip gradle.zip.sha512
  exit 1
fi
