#!/bin/bash -x

TMP=`mktemp`
NAME="$1.txt"
DATE=`date --rfc-3339=seconds`

rm a.ps

# https://stackoverflow.com/questions/24795010/text-to-pdf-with-utf8-encoding-alternative-to-a2ps
for i in $*; do
cat $i | iconv -c -f utf-8 -t ISO-8859-15 >>$TMP 
done

mv $TMP $NAME || $( echo "Name clash $NAME"; exit -1 )
enscript -G2rE -Cj -MA4 --mark-wrapped-lines=arrow -t "$1" -b "$1 $DATE" -o a.ps $NAME
rm $NAME

evince a.ps &
