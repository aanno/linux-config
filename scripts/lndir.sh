#!/bin/bash -x

# https://gist.github.com/xombiemp/4748562

oldifs=$IFS
IFS='
'
[ $# -ne 2 ] && { echo "Usage: $0 sourceDirectory destinationDirectory" ; exit 1; }
[ ! -d "$1" ] && { echo "$1 is not a valid directory"; exit 1; }
[ ! -d "$2" ] && { mkdir -p "$2"; }
src=$(cd "$1" ; pwd)
dst=$(cd "$2" ; pwd)
find "$src" -type d |
while read dir; do
        mkdir -p "$dst${dir#$src}"
done

find "$src" -type f -o -type l |
while read src_f; do
  if [ -f "$src_f" ]; then
    dst_f="$dst${src_f#$src}"
    ln "$src_f" "$dst_f"
  else
    echo "$src_f ignored (not a normal file)"
  fi
done
IFS=$oldifs
