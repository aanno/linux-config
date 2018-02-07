#!/bin/bash

# http://www.googlinux.com/update-all-docker-images/
docker images |grep -v REPOSITORY|awk '{print $1}'|xargs -L1 docker pull 
