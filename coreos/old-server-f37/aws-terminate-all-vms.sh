#!/bin/bash -x
# make a local vm from coreos image

set -eu
. env.sh

INSTANCES=`jq -r '.Reservations[].Instances[].InstanceId' describe.log.json`

for i in $INSTANCES; do
  aws ec2 terminate-instances --instance-ids $i
done

sleep 10

aws ec2 describe-instances | tee describe.log.json
