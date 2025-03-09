#!/bin/bash

source .env
export NETCUP_CUSTOMER_NUMBER NETCUP_API_KEY NETCUP_API_PASSWORD

mkdir  backup  caddy_certs  caddy_config  caddy_data  caddy_sites
cp /var/home/nc/certbot/cbconfig/live/netzgeneration.com/cert.pem caddy_certs/
cp /var/home/nc/certbot/cbconfig/live/netzgeneration.com/privkey.pem caddy_certs/

podman compose -p caddy2 up -d
podman compose -p caddy2 logs -f

