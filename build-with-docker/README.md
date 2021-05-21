# Owntone

At present the container is only for _building_ owntone, _not_ for running it!

## Fedora >=34

### SELinux (for container use, incomplete, not working)
```
# ausearch -c 'owntone' --raw | audit2allow -M my-owntone
# semodule -X 300 -i my-owntone.pp
```

### needed runtime installs

```
antlr3-C mxml libsodium libconfuse libwebsockets libspotify
```

## Ubuntu

`/usr/lib/libantlr3c.a /usr/lib/libantlr3c.la /usr/lib/libantlr3c.so`

### needed runtime installs

```
libevent-pthreads-2.1-7 libwebsockets16 libmxml1 libconfuse2 libantlr3c-3.4-0 libportaudio2
```

sudo ln -s /usr/lib/x86_64-linux-gnu/libantlr3c-3.4.so.0.0.0 /usr/lib/x86_64-linux-gnu/libantlr3c.so

## nymphcast

Fedora:
`poco-netssl poco-json poco-data poco-sqlite SDL2_image libevent libatomic`

```bash
LD_LIBRARY_PATH=./opt/owntone/lib ./opt/owntone/bin/nymphcast_server  -h
```

## Misc

### mDNS/avahi

* https://stackoverflow.com/questions/30646943/how-to-avahi-browse-from-a-docker-container

### Pipewire

* https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-PulseAudio
* https://wiki.archlinux.org/title/PipeWire

