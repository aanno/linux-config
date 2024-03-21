# wg-easy - UI for wireguard

## Quick start

```bash
./setup.sh
podman-compose down; podman-compose up
# browser on http://0.0.0.0:51821/
```

## fedora firewall

```bash
sudo firewall-cmd --add-port=51820/udp --permanent
sudo firewall-cmd --reload
```

## TODO

Currently unsafe, as HTTPS is missing. Please make sure that firewall is
configured probably: Port 51821 must be _blocked_ on your endpoint.

Using ssh port forwarding, it is nevertheless possible to use the wg-easy
web interface:

```bash
ssh -L 1821:localhost:51821 tpasch@<your-ipv4-endpoint>
xdg-open http://localhost:1821
```

Currently, wg-easy _only_ supports ipv4.

## References

### wg-easy and podman

* https://github.com/wg-easy/wg-easy
* https://github.com/wg-easy/wg-easy/wiki/Using-WireGuard-Easy-with-Podman
* https://github.com/wg-easy/wg-easy/wiki/Using-WireGuard-Easy-with-nginx-SSL

### wireguard and firewall

* [fedora firwall](https://reintech.io/blog/configuring-vpn-wireguard-fedora-38) you need to unblock port 512820 (but NEVER unblock 51821)
* [forwarding](https://discussion.fedoraproject.org/t/how-to-setup-wireguard-vpn-with-firewalld/76896) you normally need this but it is configured with podman here

```bash
```

```bash
```

```bash
```
