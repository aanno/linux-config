#!/bin/bash -x

IMAGE=fcos.qcow2
scp -P 2222 "$IMAGE" "$NC_USER@46.38.225.190:/image"

