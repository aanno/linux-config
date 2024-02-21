# gost v3

## Quick start

```bash
podman-compose down; podman-compose up
```

## Testing

### Http

```bash
curl --proxy "http://user1:pass1@localhost:8080" https://www.google.de
```

or

```bash
curl --proxy-user user1:pass1 --proxy "http://localhost:8080" https://www.google.de
```

* https://everything.curl.dev/usingcurl/proxies/auth

### Socks5

```bash
curl --socks5 "user1:pass1@localhost:1080" https://www.google.de
```

or

```bash
curl --proxy-user user1:pass1 --socks5 "http://localhost:1080" https://www.google.de
```

```bash
```

