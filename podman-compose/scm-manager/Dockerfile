FROM docker.io/scmmanager/scm-manager:3.8.0-alpine
# FROM docker.io/library/scm-manager-scm-manager:3.8.0-alpine

# scm user id
ENV userid=1000

USER root

RUN \
  mkdir -p /var/lib/scm /opt/scm-server /var/cache/scm && \
  chown -R scm:root /var/lib/scm /opt/scm-server /var/cache/scm ;

# This leads to errors
# java.lang.IllegalStateException: could not modify home directory at /var/lib/scm
# USER scm
# WORKDIR /var/lib/scm
