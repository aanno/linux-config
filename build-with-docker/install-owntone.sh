#!/bin/bash -x
# must be run as root (sudo)

CWD=`pwd`

pushd /

rm -rf /opt/owntone
tar xvfz $CWD/owntone.tar.gz
chown -R tpasch:tpasch /opt/owntone

touch /var/log/owntone.log
mkdir /var/cache/owntone
chown -R tpasch:tpasch /var/log/owntone.log /var/cache/owntone

popd

# look for missing libs
ldd /opt/owntone/sbin/owntone  | grep -i not
