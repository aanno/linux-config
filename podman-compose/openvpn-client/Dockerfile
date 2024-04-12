FROM docker.io/alpine:latest

ENV USER=openvpn
ENV GROUPNAME=$USER
ENV UID=1001
ENV GID=1001

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
&& apk add --no-cache openvpn

EXPOSE 1194
USER openvpn
ENTRYPOINT [ "/usr/sbin/openvpn", "--config", "/config/openvpn.ovpn" ]
