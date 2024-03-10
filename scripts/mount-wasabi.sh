#!/bin/bash -x

RAW_MOUNT="$HOME/.cache/wasabi/mnt"
TO_CACHE="$HOME/.cache/wasabi/to"
MOUNT="$HOME/data/wasabi"

mkdir -p $RAW_MOUNT || true
mkdir -p $TO_CACHE || true
mkdir -p $MOUNT || true

# slow: b-breitbandig
for i in b-breitbandig b-duplicati b-tps-nas; do
  # echo $i
  R="$RAW_MOUNT/$i"
  T="$TO_CACHE/$i"
  M="$MOUNT/$i"

  mkdir $R || true
  mkdir $T || true
  mkdir $M || true

  umount $R || true
  umount $M || true

  s3fs $i $R -o ro,passwd_file=${HOME}/.passwd-s3fs -o url=https://s3.eu-central-2.wasabisys.com
  # ???
  catfs $R $T $M &
done
