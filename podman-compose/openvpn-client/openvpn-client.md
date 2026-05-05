# openvpn client for getflix vpn mode

This is a simple openvpn client container for getflix vpn mode. It uses supervisord to run both openvpn and gost (a socks5 proxy) in the same container. The openvpn configuration file and the gost configuration file are mounted as volumes from the host. The container also exposes the socks5 proxy on port 1080 and the http proxy on port 3128.

The podman container is rootless, but needs CAP_NET_ADMIN to be able to set the default route to the vpn interface.
SELinux is disable in the container, and we need 'userns_mode: keep-id' to circumvent some perms problems.

Using the socks5 proxy on 1080 will with your browser will hide your IP address and make it look like you are in the 
location of the vpn server. Using the http proxy on 3128 is only proof of concept. As it does not change your
DNS, netflix functionallity is doomed. But it can be used for other purposes, like downloading files from the internet.

## Additional files

You also need a config/passfile with the following content:

```text
<getflix username>
<getflix password>
```
