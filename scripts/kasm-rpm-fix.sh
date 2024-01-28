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

rm -r kasmvncserver.dir || true
mkdir kasmvncserver.dir || true
pushd kasmvncserver.dir

  tar xvf ../kasmvncserver.tar
  mkdir -p opt/kasmvncserver/bin
  mv -f usr/bin/* opt/kasmvncserver/bin
  rmdir usr/bin

  pushd opt/kasmvncserver/bin
    ln -s vncconfig kasmvncconfig
    ln -s vncserver kasmvncserver
    ln -s Xvnc kasmXvnc
  popd

  pushd usr/share/man/man1
    mv Xvnc.1.gz kasmXvnc.1.gz
    mv vncconfig.1.gz kasmvncconfig.1.gz
    mv vncpasswd.1.gz kasmvncpasswd.1.gz
    mv vncserver.1.gz kasmvncserver.1.gz
  popd

  tar cvfz ../$NEWTAR ./etc ./usr ./opt

popd

cp kasmvncserver.fpm .fpm
fpm -s tar -t rpm $NEWTAR
