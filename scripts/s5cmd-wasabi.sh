#!/bin/bash
# https://knowledgebase.wasabi.com/hc/en-us/articles/360044600552-How-do-I-use-s5cmd-with-Wasabi-
# https://knowledgebase.wasabi.com/hc/en-us/articles/360015106031-What-are-the-service-URLs-for-Wasabi-s-different-storage-regions-
# https://github.com/peak/s5cmd

export AWS_REGION=eu-central-2
podman run --rm \
   -v $(pwd):/aws \
   -v ~/.aws:/root/.aws:z \
   -e "AWS_REGION=${AWS_REGION}" \
  docker.io/peakcom/s5cmd \
  --profile=wasabi-ro \
  --endpoint-url=https://s3.eu-central-2.wasabisys.com \
  $*

