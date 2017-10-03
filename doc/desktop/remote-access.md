# Remote access to linux desktop

## Remote Desktop (RDP)

### Remote Desktop Server (xrdp)

* Anleitung: [Fedora](https://gist.github.com/bcambl/ff17eae67863eda34c24)
* [kdeinit5 Problem auf Fedora](https://lists.fedoraproject.org/archives/list/kde@lists.fedoraproject.org/thread/3M3KMFPV25BWNHBLBNO3DHHZLDFGAAHZ/)
* Keine Probleme mit xfce: dnf install @xfce-desktop
* [So startet](http://bullcreekstudio.com/commentary/start-remote-xrdp-session-mate-debian-cuz-gnome-3-just-sucks/) man die verschiedenen Linux Desktops 

## Spice

* [Grundlagen](http://www.heise.de/ix/artikel/Gewuerzmischung-1748671.html)
* [Homepage](http://www.spice-space.org/index.html)
* [More clients and server](http://www.spice-space.org/download.html) 

### Spice Server (Linux Desktop System)

* Install `xorg-x11-server-Xspice` and `spice-server`
* Run `sudo Xspice --disable-ticketing --vdagent --xsession startkde :3` 

#### Fedora

* `Xspice --config /etc/X11/spiceqxl.xorg.conf --disable-ticketing --vdagent --xsession startxfce4 :4` 
  oder `sudo Xspice --auto --disable-ticketing --vdagent --xsession startxfce4 :4` 
  führt zu einen [Segmentation Fault](https://bugzilla.redhat.com/show_bug.cgi?id=1405939). 

### Spice Client

* Install `virt-viewer` (geht auch unter Windows!)
* Run `remote-viewer spice://localhost:5900` 

## VNC

### `x11vnc`

Der Vorteil dieser Lösung ist, dass man die bereits remote geöffnete Session 
überträgt (mit anderen Worten: den 'aktuellen' Remote Desktop) und nicht eine 
neue Session startet. Ich (tp) halte das deswegen für die beste Lösung!

Beispiel-Skript:

```
#!/bin/bash -x
# x11vnc -v -6 -reopen -loop -forever -tightfilexfer -ultrafilexfer -avahi -vncconnect -allow 192.168.1. -usepw -find -findauth -xvnc -ncache

killall -9 x11vnc 
rm ~/x11vnc.log
x11vnc -rfbauth ~/.vnc/passwd -ncache 10 -usepw -forever -avahi -find -xvnc -allow 192.168.1. -tightfilexfer -ultrafilexfer -xinerama -xwarppointer -clip xinerama0 -ssl -bg -o ~/x11vnc.log
```

Nicht jeder VNC Client funktioniert zusammen mit `x11vnc`! 
Mit [TigerVNC](http://tigervnc.org/) habe 
ich (tp) auch unter Windows gute Erfahrungen gemacht. Besonders gut ist, dass 
es einfach möglich ist, eine verschlüsselte Session im Vollbildmodus zu 
übertragen.

### Other VNC implementations

* [RealVNC](https://www.realvnc.com/en/connect/download/vnc/)
* [UltraVNC](http://www.uvnc.com/downloads/ultravnc.html)
* [TightVNC](https://www.tightvnc.com/)
* [TurboVNC](https://turbovnc.org/)
