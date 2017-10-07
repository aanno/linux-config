#!/bin/bash -x
# https://github.com/nextcloud/docker

certbot certonly -d "breitbandig.de,www.breitbandig.de,mail.breitbandig.de,netzgeneration.com,www.netzgeneration.com,mail.netzgeneration.com,v22017092131153710.goodsrv.de" --standalone
