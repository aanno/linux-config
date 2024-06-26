# Fedora

## Tipps zur Installation

* Linux für professionelle Zwecke (sowohl Server als auch Desktop) _stets_ 
  mit LVM2 einrichten, also _niemals_ Partitionen direkt verwenden.
* Linux für Desktop und Laptops stets mit Verschlüsselung einrichten. 
  Ich empfehle Vollverschlüsselung mittels LUKS. Dies wird von Fedora bereits 
  bei der Installation unterstützt.
* SSD Caching kann man problemlos _nach_ der Installation einrichten. 

## Tipps zum Upgrade

* Der Upgrade von Fedora wird zwar nicht offiziell unterstützt, funktioniert 
  meiner Erfahrung nach aber komplett problemlos: <br/>
  https://fedoraproject.org/wiki/DNF_system_upgrade
* Vor dem Upgrade ein Backup durchführen und Details zur 
  Festplattenkonfiguration, LVM2, und Verschlüsselung ausdrucken.
* Vor dem Upgrade die Seite über bekannte Probleme lesen: 
  https://fedoraproject.org/wiki/Common_F26_bugs bzw. 
  https://fedoraproject.org/wiki/Common_F25_bugs 

## Nach der Installation

* [Top things after installation](http://www.2daygeek.com/top-things-to-do-after-installing-fedora-24-workstation/#)
* [25 things to do](http://www.tecmint.com/things-to-do-after-fedora-24-workstation-installation/)
* [Using on libreoffice flatpak](https://whatofhow.wordpress.com/2016/06/01/libreoffice-5-2-beta-flatpak/) 

## Zusätzliche Repositories

* [Copr Personal Repositories](http://copr.fedorainfracloud.org/)
* http://fedoraproject.org/wiki/EPEL

### United RPMs

* https://tlhp.cf/unitedrpms-rpmfusion-alternative/
* https://unitedrpms.github.io/ 

```
dnf config-manager --add-repo=https://unitedrpms.github.io/unitedrpms.repo
wget https://raw.githubusercontent.com/UnitedRPMs/unitedrpms.github.io/master/URPMS-GPG-PUBLICKEY-Fedora-25
sudo cp ~/Downloads/URPMS-GPG-PUBLICKEY-Fedora-25.txt /etc/pki/rpm-gpg/URPMS-GPG-PUBLICKEY-Fedora-25
dnf upgrade
```

## Wichtige Fedora Seiten

* [Fedora Labs](https://labs.fedoraproject.org/)
* [Fedora Planet](http://fedoraplanet.org/) 

## Wayland

* [Known issues](https://fedoraproject.org/wiki/How_to_debug_Wayland_problems#known_issues)
* [Wayland for KDE](https://community.kde.org/KWin/Wayland) 

## Konfiguration

* [Enabling hibernation](http://blog.ordinatechnic.com/blog/2015/06/08/enabling-hibernation-suspend-to-disk-in-fedora-22/)
* [Using the fastest mirror with dnf](http://www.theironsamurai.com/dnf-slow-on-fedora-add-fastestmirror-to-your-dnf-conf/)
* Things to do after installing Fedora: 
  [1](http://www.tecmint.com/things-to-do-after-fedora-23-installation/), 
  [2](http://www.binarytides.com/better-fedora-23/), 
  [3](https://www.linux.com/learn/11-things-do-after-installing-fedora-22) 
* [modularity](https://docs.fedoraproject.org/en-US/modularity/)

### User zum Admin machen (sudo Rechte)

* `usermod sampleusername -a -G wheel` <br/>
  Referenz: [1](http://fedoraproject.org/wiki/Configuring_Sudo)

### SSH server aktivierten

* `dnf install openssh-server`
* `systemctl start sshd.service`
* `systemctl enable sshd.service`
* Evt. Firewall umkonfigurieren 

Referenz: 
[1](https://docs.fedoraproject.org/en-US/Fedora/18/html/System_Administrators_Guide/s2-ssh-configuration-sshd.html), 
[2](http://www.techotopia.com/index.php/Configuring_Fedora_Linux_Remote_Access_using_SSH)

### LUKS Festplatten Vollverschlüsselung

Fedora lässt sich bequem bei der Installation so konfigurieren, dass 
alle Festplatten (Partitionen, Swap) mit LUKS verschlüsselt sind. 

(Im Gegensatz dazu konnten bei Ubuntu lange nur die Home 
Verzeichnisse der einzelnen Nutzer verschlüsselt werden. Das ist 
etwas anderes - und unter Fedora bei der Installation m.W. nicht 
möglich.)

#### Mehr Entschlüsselungspasswörter

LUKS erlaubt bis zu 8 Entschlüsselungspasswörter pro verschlüsselter Partition - folglich müssen sich nicht alle User ein Festplattenpasswort teilen.

1. `cat /etc/crypttab` und dort die UUIDs der LUKS Partitionen entnehmen.
2. `blkid -U <uuid>` um die physikalische Partition herauszubekommen.
3. `cryptsetup isLuks -v /dev/<sda4>` um sicherzustellen, dass man eine LUKS Partition erwischt hat.
4. `cryptsetup luksAddKey /dev/<sda4>` um einen neuen Schlüssel hinzu zu fügen. 

Referenz: [1](https://unixfuntime.wordpress.com/2012/08/20/luks-passphrases-changing-adding-removing/)

#### Weitere Luks Commandos

Liste alle Luks Partitionen auf 
[1](https://unix.stackexchange.com/questions/185390/list-open-dm-crypt-luks-volumes):

```
$ sudo dmsetup ls  --target crypt
luks-d06d9725-48db-4b3f-bc21-b7daa38a5264       (253, 3)
luks-a9eba963-ff2e-499b-a298-0659c5e29359       (253, 0)
```

Überprüfe, ob Device Luks konfiguriert ist:

```
$ sudo cryptsetup -v isLuks /dev/sda5
Befehl erfolgreich.
```

Zeige Einstellungen eines Luks Device:

```
$ sudo cryptsetup -v status luks-d06d9725-48db-4b3f-bc21-b7daa38a5264                                              
/dev/mapper/luks-d06d9725-48db-4b3f-bc21-b7daa38a5264 is active and is in use.                                                               
  type:    LUKS1
  cipher:  aes-xts-plain64
  keysize: 512 bits
  device:  /dev/sdb4
  offset:  4096 sectors
  size:    1108606461 sectors
  mode:    read/write
Befehl erfolgreich.
```

#### Nachträglich Luks Device einrichten

Anleitung: https://wiki.ubuntuusers.de/LUKS/ und dann Device in 
`/etc/crypttab` eintragen.

### LVM2 - der Linux Volume Manager

Einführung: https://wiki.ubuntuusers.de/Logical_Volume_Manager/

Logical Volume `ssdtmp` in der VG `vg_hdd` auf Festplatte 
`luks-aa8fd8fc-ff77-4f86-9420-b8588c1eedce` erzeugen 
[1](https://www.centos.org/docs/5/html/Cluster_Logical_Volume_Manager/LV_create.html):

```
$ sudo lvcreate -L 30G -n ssdtmp vg_hdd /dev/mapper/luks-aa8fd8fc-ff77-4f86-9420-b8588c1eedce
  Logical volume "ssdtmp" created.
```

Herausfinden, auf welcher Festplatte sich ein Logical Volume befindet 
[1](https://serverfault.com/questions/461385/how-to-find-the-physical-volumes-that-hold-a-logical-volume-in-lvm):

```
$ sudo pvdisplay -m
$ sudo lvs -o +devices
```

### SSD Cache für HDDs/Festplatten mittels lvmcache

1. Zunächst das Luks Device einrichten (falls noch nicht geschehen).
2. Der Cache auf der SSD und die Partition auf der HDD müssen _in derselben 
   *lvm volume group* sein_. Falls das jetzt nicht so ist, ist `vgmerge` 
   hilfreich. 
   
   (Online man page z.B. https://linux.die.net/man/8/vgmerge)
3. Die man page zu `lvmcache` enthält eine _komplette_ Anleitung 

   (Online z.B. http://manpages.ubuntu.com/manpages/yakkety/man7/lvmcache.7.html) 

### SELinux und Firewall

Fedora ist von Hause aus besonders sicher. Im Desktopbetrieb heißt das erst 
einmal, dass die Einrichtung neuer Dienste auf größere Schwierigkeiten treffen 
kann. Als Beispiel hier die richtige Einrichtung von xrdp 
([Quelle](https://gist.github.com/bcambl/ff17eae67863eda34c24)):

```
#!/bin/bash
#################################################
# Setup Fedora 23 Gnome3 with xRDP via XFCE4
#################################################

# install the XFCE4 desktop
sudo dnf groupinstall xfce-desktop

# open standard RDP ports
sudo firewall-cmd --add-port=3389/tcp
sudo firewall-cmd --permanent --add-port=3389/tcp

# install TigerVNC and xRDP
sudo dnf install tigervnc tigervnc-server
sudo dnf install xrdp

# stop disabling SELinux
sudo chcon --type=bin_t /usr/sbin/xrdp
sudo chcon --type=bin_t /usr/sbin/xrdp-sesman

# enable xRDP service
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman

# start xRDP service
sudo systemctl start xrdp-sesman
sudo systemctl start xrdp.service

# set XFCE4 desktop for RDP connections
sudo echo "startxfce4" > ~/.Xclients
sudo chmod +x ~/.Xclients
sudo systemctl restart xrdp.service
```

## Further Software

Interessante zusätzliche Programme

* [Fedy Fedora Tweaker](http://folkswithhats.org/)
* [Yum Extender](https://fedorahosted.org/yumex/): Package Manager UI
* Stand von KDE Plasma auf Fedora: 
  [1](https://community.kde.org/Plasma/Packages), 
  [2](https://apps.fedoraproject.org/packages/plasma-workspace) 

## firewallD

* https://www.linode.com/docs/security/firewalls/introduction-to-firewalld-on-centos
* https://www.certdepot.net/rhel7-get-started-firewalld/
* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using_firewalls#sec-Introduction_to_firewalld
* [masquerade](https://www.server-world.info/en/note?os=CentOS_7&p=firewalld&f=2)
* [postrouting symmetrical NAT](https://unix.stackexchange.com/questions/539828/how-to-use-postrouting-snat-with-firewalld)
* https://fedoraproject.org/wiki/Firewalld?rd=FirewallD
* http://www.firewalld.org/

## iptables

* http://www.thegeekstuff.com/2011/01/iptables-fundamentals/

## nftables (nft)

* [arch nft overview](https://wiki.archlinux.org/index.php/nftables)
* [quick howto](https://home.regit.org/netfilter-en/nftables-quick-howto/)
* http://kangran.su/~nnz/pub/nf-doc/nftables/nft.html
* [nft wiki](https://wiki.nftables.org/wiki-nftables/index.php/Main_Page)
* [nft examples](https://github.com/mqus/nft-rules)
  + [nft vpn example](https://github.com/mqus/nft-rules/blob/master/files/VPN.md)

## SELinux

* [labels and contexts](https://www.thegeekdiary.com/understanding-selinux-file-labelling-and-selinux-context/)
* [linux capabilities](https://blog.container-solutions.com/linux-capabilities-in-practice)
