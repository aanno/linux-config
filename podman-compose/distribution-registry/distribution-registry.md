# distribution registry v2

Simple docker registry from the docker community.

## Create htpasswd file 

Create file and first users:
```bash
htpasswd -cbB htpasswd user1 pass1
```

Create other users:
```bash
htpasswd -bB htpasswd user2 pass2
```

## Testing

```bash
podman tag docker.io/aanno/gost localhost:5000/aanno/gost
# use an user from htpasswd file
podman login --tls-verify=false localhost:5000
podman push --tls-verify=false localhost:5000/aanno/gost
# local remove - _not_ from registry
podman rmi localhost:5000/aanno/gost
podman pull --tls-verify=false localhost:5000/aanno/gost
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



## References

* [documentation](https://distribution.github.io/distribution/about/configuration/)
* [docker image](https://hub.docker.com/_/registry)
* [github](https://github.com/distribution/distribution)
