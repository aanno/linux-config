#!/bin/bash -x

set -ehx

CWD=`pwd`
RPM=$1
shift

NEWTAR=kasmvncserver-1.2.0.tar
SCRIPT_DIR=`dirname $0`

rm kasmvncserver.tar kasmvncserver-*.rpm kasmvncserver.fpm .fpm || true
cp $SCRIPT_DIR/kasmvncserver.fpm .
fpm -s rpm -t tar $RPM

mkdir kasmvncserver.dir || true
pushd kasmvncserver.dir
  tar xvf ../kasmvncserver.tar
  mkdir -p opt/kasmvncserver/bin
  mv -f usr/bin/* opt/kasmvncserver/bin
  rmdir usr/bin
  tar cvfz ../$NEWTAR ./etc ./usr ./opt
popd

cp kasmvncserver.fpm .fpm
fpm -s tar -t rpm $NEWTAR
