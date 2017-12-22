# Use Qnap TS-228

## Hilfs- und Dienstprogramme

* Desktop: https://www.qnap.com/de-de/utilities
* Mobile: https://www.qnap.com/de-de/mobile-apps/
* Offical App Center: https://www.qnap.com/en/app_center/index.php?qts=4.3.3&type=2&II=217&for_qts4=&hf=

## Mount Volumes

### Linux

#### Traditional `fstab` smb mounts

In `/etc/fstab` add the lines:

```
//192.168.10.58/Musik /media/nas/Musik cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
//192.168.10.58/Multimedia /media/nas/Multimedia cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
//192.168.10.58/Download /media/nas/Download cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
//192.168.10.58/Public /media/nas/Public cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
//192.168.10.58/Recordings /media/nas/Recordings cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
//192.168.10.58/home /media/nas/home cifs uid=1000,gid=100,vers=2.1,credentials=/home/tpasch/.smbcredentials  0 0
```

The credentials file should look like `/home/tpasch/.smbcredentials`:

```
username=unke
password=<password>
```

Restrict access to this file by:

``` bash
chmod 0600 /home/tpasch/.smbcredentials
```

* https://wiki.ubuntuusers.de/Samba_Client_cifs/

## NFS

* https://wiki.ubuntuusers.de/NFS/

## Backup

### Rsync

Links:

* https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/
* https://wiki.ubuntuusers.de/Skripte/Backup_mit_RSYNC/
* http://blog.gestreift.net/2015/09/backup-per-rsync-auf-qnap/
* https://www.qnap.com/de-de/how-to/tutorial/article/setup-der-fernreplikation-auf-dem-qnap-turbo-nas

#### Preliminaries

1. Download App 'Hybrid Backup Sync' from App Store
2. In its settings, enable rsync (set user and password)
3. (Optional) setup local backup space

#### Use over SMB

Given than /media/nas/Musik is a smb-mounted folder on NAS:

``` bash
#!/bin/bash -x
cd
rm nohup.out
nohup rsync -avhcS Musik/ /media/nas/Musik &
less nohup.out
```

* Only minor configuration required.

### Direct user

``` bash
rsync Musik/ -avhcS rsync://rsync@192.168.10.58:/Backup
```

* For this usage, you need the local backup space `Backup`.
* You need to type in the password.

#### rsync over ssh user

``` bash
rsync Musik/ -avhcSe ssh admin@192.168.10.58:/Download
```

* For this usage, you need to use an NAS user with administrator privileges
  (admin in this example).
* You need to type in the password OR setup certificate ssh login.
