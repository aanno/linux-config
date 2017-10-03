# Networking

## Networking on fedora

* https://www.systutorials.com/137102/how-to-set-the-static-ip-address-using-cli-in-fedoracentos-linux/

### ipv6

Fedora 26 uses NetworkManager even on a server install. Hence most ipv6 
configuration you find on the internet are either misleading or plain
wrong.

It turns out that netcup has DHCP support for ipv4 (hence there is no 
static configuration of the ipv4 address needed). But there is no
DHCP ipv6 support. Hence, for ipv6 you need `radvd`. This is the
proposed configuration.

In `/etc/radvd.conf`:
```
interface ens3
{
   IgnoreIfMissing on;
   AdvSendAdvert on;
   # test-ipv6.com
   # AdvLinkMTU 1280;
   MinRtrAdvInterval 30;
   MaxRtrAdvInterval 60;
   prefix dead:beef:cafe::/64
   {
        AdvOnLink on;
        AdvAutonomous on;
        AdvRouterAddr on;
   };
};
```

In `/etc/sysconfig/network-scripts/ifcfg-ens3`:
```
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
# modified by tp
# https://unix.stackexchange.com/questions/331129/stable-ipv6-address-on-fedora
# https://developer.gnome.org/NetworkManager/stable/nm-settings-ifcfg-rh.html
# IPV6_ADDR_GEN_MODE=stable-privacy
IPV6_ADDR_GEN_MODE=eui64
NAME=ens3
UUID=307a48ad-82ed-3034-8c5d-797e444f2d76
ONBOOT=yes
AUTOCONNECT_PRIORITY=-999
DEVICE=ens3

# added by tp
IPV6ADDR=dead:beef:cafe::1
IPV6ADDR_SECONDARIES="dead:beef:cafe::2 dead:beef:cafe::3"
```

* https://unix.stackexchange.com/questions/331129/stable-ipv6-address-on-fedora
* https://developer.gnome.org/NetworkManager/stable/nm-settings-ifcfg-rh.html
* https://fedoraproject.org/wiki/IPv6Guide
* https://fedoraproject.org/wiki/Tools/NetworkManager/IPv6
* https://docs-old.fedoraproject.org/en-US/Fedora/15/html/Deployment_Guide/s1-dhcp_for_ipv6_dhcpv6.html

### ipv6 basics

* http://www.elektronik-kompendium.de/sites/net/1902141.htm
  dhcpv6
* https://www.elektronik-kompendium.de/sites/raspberry-pi/1912201.htm
  ipv6 gateway
