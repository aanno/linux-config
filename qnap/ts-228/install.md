# Install Qnap TS-228

## Official Qnap Apps

* File Station
* myQNAPcloud
  + https://www.myqnapcloud.com/
  + https://support.myqnapcloud.com/features?lang=en
* App Center
* Help Desk
* Qsync Central
* Media Streaming Add-on
  + NAS Login: https://192.168.10.58/apps/upnp/extjs-3.3.3/myupnp/login.html
* QTS SSL Certificate
* Photo Station
* QNAP Diagnostic Tool
* VirtualHere USB Sharing
  + http://www.virtualhere.com/nas_faq
* Musik Station
* Video Station
* WebDAV (Backup NAS to Cloud)
* Container Station (Docker and LXC)
  + https://www.qnap.com/en/how-to/tutorial/article/how-to-use-container-station
  + https://www.qnap.com/solution/qiot-containers/en/
* Hybrid Backup Sync (Rsync, RTRR, and Cloud Backup)
* Resource Monitor (Control Center)
* JRE (needed for Serviio)

## Unofficial Qnap Apps

* Alternative QNAPclup App Center
  + https://www.qnapclub.eu/index.php?act=howto
* Serviio
  + NAS Login: https://192.168.10.58:23523/console/#/app/welcome
  + Download: http://serviio.org/download (use ARM x41+)
* BubbleUPNP Server
  * NAS: http://192.168.10.58:58050/#main
  + Download: http://www.bubblesoftapps.com/bubbleupnpserver/#qnap_install

## Optware-ng

Optware-ng is a package system for ARM IoT devices and it is recommended/needed by the BubbleUPNP Server (http://www.bubblesoftapps.com/bubbleupnpserver/#qnap_install).

Installation is described at https://github.com/Optware/Optware-ng#getting-started .

1. Optware-ng is installed in `/opt`. However, the is no space for it on the mount.
   Hence we need some symlinks: /opt -> /share/optware-ng -> /share/CACHEDEV1_DATA/optware-ng
2. `wget -O - http://ipkg.nslu2-linux.org/optware-ng/bootstrap/buildroot-armeabihf-bootstrap.sh | sh`
3. `/opt/bin/ipkg install ffmpeg`
4. You could get the list of packages at http://ipkg.nslu2-linux.org/optware-ng/buildroot-armeabihf/

## Links

* Nextcloud und Apache <br/>
  + https://xspone.com/2017/03/internet-und-netzwerk/nextcloud-auf-qnap-nas-installieren/
* Git UI https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Access_control_.2F_Project_hosting
  + Gitea (Go) https://docs.gitea.io/en-us/
  + Gitbucket (Scala) https://github.com/gitbucket/gitbucket
  
  
