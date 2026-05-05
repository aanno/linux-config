FROM docker.io/alpine:latest

ENV USER=openvpn
ENV GROUPNAME=$USER
ENV UID=1000
ENV GID=1000

RUN addgroup \
    --gid "$GID" \
    "$GROUPNAME" \
&&  adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$GROUPNAME" \
    --no-create-home \
    --uid "$UID" \
    $USER \
&& apk add --no-cache openvpn iproute2 bind-tools supervisor gost

# iproute2: for ip command
# bind-tools: for host command
# supervisor: for running multiple processes, see https://supervisord.org
# gost: for running a socks5 proxy, see https://gost.run/en/
# gost -C /config/gost.yml

EXPOSE 1194
USER openvpn
ENTRYPOINT [ "/usr/sbin/openvpn", "--config", "/config/openvpn.ovpn" ]
