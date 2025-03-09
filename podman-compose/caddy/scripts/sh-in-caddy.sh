#!/bin/bash

podman run -v ./backup:/backup:z -v /var/home/nc/certbot/cbconfig/live/netzgeneration.com:/certs-extern:ro,z --rm -it docker.io/library/caddy:latest sh

