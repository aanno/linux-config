#!/bin/bash -x

# must match the url region
export AWS_REGION=eu-central-2
# https://knowledgebase.wasabi.com/hc/en-us/articles/360044600552-How-do-I-use-s5cmd-with-Wasabi
# https://knowledgebase.wasabi.com/hc/en-us/articles/360015106031-What-are-the-service-URLs-for-Wasabi-s-different-storage-regions
s5cmd --endpoint-url https://s3.eu-central-2.wasabisys.com --profile wasabi-ro $*
