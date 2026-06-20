# openvpn-client for getflix VPN

This is a configuration for using getflix VPN openvpn configuration in a podman container
With the help of gost, the VPN could be used with SOCKS5, for example in a browser.

## Setup 

Add your VPN user/pw to `config/passfile` adhering to the following template:

```txt
<username>
<password>
```

The start with `./start-openvpn-client.sh`.

## How it works

* Container starts openvpn _and_ gost with the help of supervisord.

## Gotchas

### DNS

This seems to be the trickiest part: Force DNS usage, but _not_ all over the place.
This setup has worked for me:

* Don't set DNS in openvpn
  (Result: It uses DNS from podman compose configuration, see below.)
* Don't set DNS/resolve in gost
  (Result: It uses DNS from podman compose configuration, see below.)
* _Set_ DNS in podman compose

### SOCKS5 for browser

* FoxyProxy Standard is a extension for firefox and chrome that is known to work in this setup.
