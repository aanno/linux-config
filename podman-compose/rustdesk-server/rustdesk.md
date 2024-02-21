# Rustdesk on Fedora

## Server (on podman)

### selinux

Open ports with:

```bash
semanage port -a -t ocsp_port_t  -p tcp 21115
semanage port -a -t ocsp_port_t  -p tcp 21116
semanage port -a -t ocsp_port_t  -p tcp 21117
semanage port -a -t ocsp_port_t  -p udp 21116
# web client
semanage port -a -t ocsp_port_t  -p tcp 21118
semanage port -a -t ocsp_port_t  -p tcp 21119
```

Test with (all this _should hang_):

```bash
cat < /dev/tcp/192.168.10.137/21115
cat < /dev/tcp/192.168.10.137/21116
cat < /dev/tcp/192.168.10.137/21117
cat < /dev/udp/192.168.10.137/21116
# web client
cat < /dev/tcp/192.168.10.137/21118
cat < /dev/tcp/192.168.10.137/21119
```

```bash
ausearch -c 'rustdesk' --raw | audit2allow -M my-rustdesk
semodule -X 300 -i my-rustdesk.pp
```

Danger zone (?!?):

```bash
ausearch -c 'tokio-runtime-w' --raw | audit2allow -M my-tokioruntimew
semodule -X 300 -i my-tokioruntimew.pp
```


## Client

* [rpms for rustdesk client](https://github.com/rustdesk/rustdesk/releases)
* settings: ID-Server should be given as IPv4 address (e.g. 192.168.10.137)

## References

* [self-host rustdesk server](https://rustdesk.com/docs/en/self-host/) includes firewall tips and ports numbers
* [docker-compose for rustdesk](https://rustdesk.com/docs/de/self-host/rustdesk-server-oss/docker/)
* [rustdesk web](https://rustdesk.com/docs/en/dev/build/web/)
* [test host and port](https://superuser.com/questions/621870/test-if-a-port-on-a-remote-system-is-reachable-without-telnet)
* [right setup of podman rootless](https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md)
* [podman rootful](https://raesene.github.io/blog/2020/02/23/More-Podman/)


```bash
```

