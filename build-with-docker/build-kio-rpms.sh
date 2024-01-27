#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`

pushd opt/owntone

  cd aws-sdk-cpp-install
  tar cvfz $CWD/aws-sdk-cpp.tgz .
  #cd ../kio-extra-install
  #tar cvfz $CWD/kio-extra.tgz .
  cd ../kio-s3-install
  tar cvfz $CWD/kio-s3.tgz .
  #cd ../kio-zeroconf-install
  #tar cvfz $CWD/kio-zeroconf.tgz .

popd

ls *.tgz

cp aws-sdk-cpp.fpm .fpm
fpm aws-sdk-cpp.tgz

#cp kio-extra.fpm .fpm
#fpm kio-extra.tgz

cp kio-s3.fpm .fpm
fpm kio-s3.tgz

#cp kio-zeroconf.fpm .fpm
#fpm kio-zeroconf.tgz

rm .fpm
