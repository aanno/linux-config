# dns-for-compose

This is an example how to set up coredns as an DNS server for pods within podman compose.
coredns is setup to use the (normal, forwarding) DNS server of podman

## How does it work

This is a tricky setup that does _not_ require normal compose containers (except coredns) 
to configure anything for DNS **but still uses coredns for resolution**.

* network is created with (upstream) dns set to 10.89.4.4
* upstream dns is the coredns container
* the coredns container forwards (unknown) requests to gateway
* in podman gateway also serves as (forwarding) dns server
* no idea why we don't loop between coredns and gateway

## network

```bash
podman network create --subnet 10.89.4.0/24 --gateway 10.89.4.1 --dns 10.89.4.4 --driver bridge dnsexample
```

```bash
$ podman network inspect dnsexample
[
     {
          "name": "dnsexample",
          "id": "5e696f1590f9dda0a76530855eac13616fba2aeabdb6e1156967e5202bd806f0",
          "driver": "bridge",
          "network_interface": "podman5",
          "created": "2025-02-01T17:41:44.400469396+01:00",
          "subnets": [
               {
                    "subnet": "10.89.4.0/24",
                    "gateway": "10.89.4.1"
               }
          ],
          "ipv6_enabled": false,
          "internal": false,
          "dns_enabled": true,
          "ipam_options": {
               "driver": "host-local"
          },
          "containers": {}
     }
]
```

## Links

* [Running CoreDNS as a DNS Server in a Container](https://dev.to/robbmanes/running-coredns-as-a-dns-server-in-a-container-1d0)
* [coredns manual](https://coredns.io/manual/toc/)
* [coredns at github](https://github.com/coredns/coredns)
