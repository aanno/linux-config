# Docker on fedora

## Unresolved issues

### Docker, firewalld, and `bridge` mode

#### Problem

In `/var/log/firewalld`, you encounter:
```
2017-10-02 18:22:24 WARNING: COMMAND_FAILED: '/usr/sbin/iptables -w2 -t filter -C DOCKER ! -i docker0 -o docker0 -p tcp -d 172.17.0.2 --dport 80 -j ACCEPT' failed:
```

#### Solution

* https://github.com/moby/moby/issues/16137#issuecomment-271615192
* https://github.com/firewalld/firewalld/issues/195

```
nmcli connection modify docker0 connection.zone trusted
systemctl stop NetworkManager.service
firewall-cmd --permanent --zone=trusted --change-interface=docker0
systemctl start NetworkManager.service
nmcli connection modify docker0 connection.zone trusted
systemctl restart docker.service
```

However, this does *not* solve the problem!
