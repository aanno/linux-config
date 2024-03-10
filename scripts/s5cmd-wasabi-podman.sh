#!/bin/bash -x
# https://knowledgebase.wasabi.com/hc/en-us/articles/360044600552-How-do-I-use-s5cmd-with-Wasabi-
# https://knowledgebase.wasabi.com/hc/en-us/articles/360015106031-What-are-the-service-URLs-for-Wasabi-s-different-storage-regions-
# https://github.com/peak/s5cmd

if [[ -z $WASABI_PROFILE ]]; then
  WASABI_PROFILE=wasabi-ro
fi

export AWS_REGION=eu-central-2
podman run --rm \
   -v $(pwd):/aws \
   -v ~/.aws:/root/.aws:z \
   -e "AWS_REGION=${AWS_REGION}" \
  docker.io/peakcom/s5cmd \
  --profile=${WASABI_PROFILE} \
  --endpoint-url=https://s3.eu-central-2.wasabisys.com \
  $*

