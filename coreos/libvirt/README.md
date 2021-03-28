# Fedora CoreOS (FCOS)


## Run once

* (Only) use local `dnscrypt-proxy` as resolver
  + `sudo resolvectl dns enp1s0 127.0.0.1 ::1`
* Enable cockpit (see https://cockpit-project.org/running#coreos)
  + `sudo podman container runlabel --name cockpit-ws RUN docker.io/cockpit/ws`
  + `sudo podman container runlabel INSTALL docker.io/cockpit/ws`
  + `sudo systemctl enable cockpit.service`

## Config

* [fcc examples](https://coreos.github.io/fcct/examples/)
* [vultr example](https://www.vultr.com/docs/ignition)

## On netcup

* https://www.matthiaspreu.com/posts/fedora-coreos-embed-ignition-config/
* https://forum.netcup.de/administration-eines-server-vserver/vserver-server-kvm-server/p140914-installation-von-fedora-coreos-auf-vps

## Firewall

* https://github.com/coreos/fedora-coreos-tracker/issues/467


## Cool self-hosting software

* [mistborn](https://gitlab.com/cyber5k/mistborn) run our own privacy protecting family server
