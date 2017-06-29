#!/bin/bash -x
# http://troy.jdmz.net/rsync/index.html

cd /run/media/tpasch/TOSHIBA_EXT4/rsync
rm nohup.out

# perhaps include -c for compress? (tp)
nohup rsync -avrz -e ssh tpasch@192.168.10.12:Musik . &
