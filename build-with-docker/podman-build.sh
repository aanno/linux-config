#!/bin/bash -x

set -xe

# https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container
CWD=`pwd`

rm -rf ./opt || true
rm *.gz *.tgz || true
podman rmi localhost/owntone || true

mkdir -p $CWD/opt/owntone \
  $CWD/var/lib/apt $CWD/var/cache/apt \
  $CWD/var/lib/dnf $CWD/var/cache/dnf \
  $CWD/.cargo $CWD/.rustup;
rm -rf $CWD/opt/owntone/* || true;
podman build --pull -t owntone \
  -v $CWD/var/lib/apt:/var/lib/apt:z \
  -v $CWD/var/cache/apt:/var/cache/apt:z \
  -v $CWD/var/lib/dnf:/var/lib/dnf:z \
  -v $CWD/var/cache/dnf:/var/cache/dnf:z \
  -v $CWD/opt:/opt:z \
  -v $CWD/.cargo:/root/.cargo:z \
  -v $CWD/.rustup:/root/.rustup:z \
  -f Containerfile.gmrender.fedora41;

# all except ..
# tar cvfz owntone.tar.gz ./opt/
# ... gmrender
cd opt
tar cvfz ../gmrender.tar.gz ./usr
cd ..
cp gmrender-fedora.fpm .fpm
sudo /root/.local/share/gem/ruby/3.3.0/bin/fpm

# rm -rf ./opt
# podman rmi localhost/owntone

# only for spotifyd
# TODO: find container name ('relaxed_torvalds' here)
# podman cp relaxed_torvalds:/opt/owntone/release/spotifyd .

# galera-4
# cp opt/owntone/make-it-longer/galera-4-26.4.18/galera-4-26.4.18.tgz .
# cp galera-4.fpm .fpm
# fpm galera-4-26.4.18.tgz

# only owntone on fedora
# rm -f *.rpm *.deb
# cp -f owntone-fedora.fpm .fpm
# sudo /root/.local/share/gem/ruby/3.3.0/bin/fpm
# dnf install ./owntone-server-2*.rpm

