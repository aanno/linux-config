# https://hub.docker.com/_/caddy
FROM docker.io/library/caddy:2.9.1-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/netcup

FROM docker.io/library/caddy:2.9.1-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
