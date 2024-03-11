# podman-compose superset

```bash
./start-superset.sh
```

```bash
xdg-open http://localhost:8088
```

## Build superset docker image with podman

```bash
podman build -t superset --security-opt label=disable .
```

## WARNING Memory overcommit must be enabled!

 Without it, a background save or replication may fail under low memory condition. Being disabled, it can also cause failures without low memory condition, see https://github.com/jemalloc/jemalloc/issues/1328. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.

## Reference

* [docker-compose superset](https://superset.apache.org/docs/installation/installing-superset-using-docker-compose/)
* [podman security-opt](https://docs.podman.io/en/v4.6.1/markdown/options/security-opt.html)

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

```bash
```

