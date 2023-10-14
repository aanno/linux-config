#!/bin/bash -x

LOCAL=$1
shift
REMOTE=$1
shift

MERGE=$REMOTE

if [ "$MERGE" = "/dev/null" ]; then
  MERGE="$BASE"
fi

kdiff3 -o $MERGE $LOCAL $REMOTE


