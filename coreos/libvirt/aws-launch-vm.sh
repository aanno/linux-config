#!/bin/bash -x
# make a local vm from coreos image

set -eu
. env.sh

CONFIG_FILE_NAME=my
VM_NAME="fcos-37"
TMP=`mktemp -d`

# g2.2xlarge - 1 GPU Nvidia K520
# p2.xlarge - 1 GPU Nvidia K80
# 
# t2.micro - kostenlos
# t3.small - known to work

NAME='fcos1'
SSHKEY='redsnapper-tp'     # the name of your SSH key: `aws ec2 describe-key-pairs`
IMAGE='ami-097f5ccd7b9deca93'     # the AMI ID found on the download page
DISK='20'           # the size of the hard disk
REGION='eu-central-1'  # the target region
TYPE='t2.micro'     # the instance type
SUBNET='subnet-ae95e7c4' # the subnet: `aws ec2 describe-subnets`
SECURITY_GROUPS='sg-08c516b4328e8e738' # the security group `aws ec2 describe-security-groups`
# USERDATA='/path/to/config.ign' # path to your Ignition config

fcct -p -s -d . -o "${CONFIG_FILE_NAME}.ign" "${CONFIG_FILE_NAME}.fcc" || exit -1
cp "${CONFIG_FILE_NAME}.ign" "$TMP/${CONFIG_FILE_NAME}.ign"

# absolute path needed
# IGNITION_CONFIG=`readlink -f "${CONFIG_FILE_NAME}.ign"`
IGNITION_CONFIG="$TMP/${CONFIG_FILE_NAME}.ign"
chmod -R o+rx "$TMP"
# https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t "$TMP/${CONFIG_FILE_NAME}.ign"

aws ec2 run-instances                     \
    --region $REGION                      \
    --image-id $IMAGE                     \
    --instance-type $TYPE                 \
    --key-name $SSHKEY                    \
    --subnet-id $SUBNET                   \
    --security-group-ids $SECURITY_GROUPS \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${NAME}}]" \
    --block-device-mappings "VirtualName=/dev/xvda,DeviceName=/dev/xvda,Ebs={VolumeSize=${DISK}}" \
    --user-data "file://${IGNITION_CONFIG}"      \
    --instance-market-options file://spot-options.json \
    >run.log.json

#--instance-market-options file://spot-options.json \
#--user-data "file://${IGNITION_CONFIG}"      \
#--user-data "https://breitbandig.de/nextcloud/s/TRAqLnHBeMqgZtR/download?path=.&files=my.ign" \

rm -rf "$TMP"

sleep 10
aws ec2 describe-instances >describe.log.json
