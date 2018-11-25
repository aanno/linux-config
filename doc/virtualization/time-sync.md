# Time synchronization on virt

General rule:

* On host (linux) system, use NTP.
* On guest (linux) system NTP is normally not needed (see below).

## Find out if host or guest

If you want to find out, if you are on a host or a guest:

* You can look for the 'hypervisor' flag in /proc/cpuinfo
* You can use the `virt-what` cli command

See https://unix.stackexchange.com/questions/3685/find-out-if-the-os-is-running-in-a-virtual-environment
for details.

## Use NTP (on host)

* The NTP (daemon) package is often an overkill. You don't need that if you
  don't want to run a NTP server (i.e. you need the machine for NTP clients).
* Many DSL routers and NAS do provide an NTP server out of the box. 
  Just switch it on.
* `ntpdate` is great for testing NTP servers BUT NOT MAINTAINED ANY MORE.
  See `man ntpdate` for details.
* `systemd` includes an NTP client from version 213 on.
  See https://wiki.ubuntuusers.de/systemd/timesyncd/ or
  https://wiki.archlinux.org/index.php/systemd-timesyncd for details.
  
## Time sync on guests

* If you got a para-virtualized clock (`cat /sys/devices/system/clocksource/clocksource0/available_clocksource`)
  be sure that you use it (`cat /sys/devices/system/clocksource/clocksource0/current_clocksource`).
  The thing is called 'kvm-clock'. 
* If there is no 'kvm-clock' and systemd-timesyncd is available, use that.
* If there is no 'kvm-clock' and no systemd-timesyncd, use NTP.
