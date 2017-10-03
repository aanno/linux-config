# Postfix

* https://docs-old.fedoraproject.org/en-US/Fedora/25/html/SELinux_Users_and_Administrators_Guide/chap-Managing_Confined_Services-Postfix.html

## Local delivery only

* http://cafim.sssup.it/~giulio/other/Postfix_Setup_for_Local_Mail_Only.html

## Smarthost

Konfiguriere Postfix als Smarthost
Man kann Postfix als sog. Smarthost konfigurieren, d.h. dass alle zu 
versendenden Emails an einen anderen Mailserver weitergeleitet werden. Dies 
ist z.B. sehr nützlich, falls eine Applikation nur lokales Mailing unterstützt 
und kein verwenden eines anderen Mailserver und keine Authentifizierung 
unterstützt. Dadurch erreicht man eine für die Applikation transparente 
Konfiguration.

### Ergebnis

* Lokaler MTA (Mail Transfer Agent), der zum eigentlichen Versenden den 
  konfigurierten Host verwendet.
* Gut für: Linux Server, bei denen ein Mailversand erwünscht, aber die 
  'richtige' Konfiguration eines MTAs (Spamfilter, Domain-Überprüfung, ...) 
  vermieden werden soll. 

### Konfiguration

1. Create password maps file (it assigns username/passwords to specified 
   mail servers). 
   
   You can choose any name, let's say it is /etc/postfix/relay_passwd.
   It's content should be as follows:
   ```
   mail.siteos.de USERNAME:PASSWORD 
   ```     
   Note: Replace USERNAME and PASSWORD with your mail relay username and PASSWORD.
2. Set proper permissions for that file:    
   ```
   chown root:root /etc/postfix/relay_passwd  
   chmod 600 /etc/postfix/relay_passwd     
   ```
3. Create hash from maps file (remember to do it each time you change your maps file):   
   ```
   postmap /etc/postfix/relay_passwd   
   ```
4. Configure your `/etc/postfix/main.cf`:
   ```
   relayhost = [<your_mta_server_name>]
   #smtp_fallback_relay = [relaybackup.dnsexit.com]
   smtp_sasl_auth_enable = yes  
   smtp_sasl_password_maps = hash:/etc/postfix/relay_passwd  
   smtp_sasl_security_options =    
   ```
5. Reload or restart your postfix:
   ```
   service postfix check
   service postfix restart
   ```

### Verifikation
Prüfen kann man es, indem man sich die Header einer Email ansieht, das 
Smarthostziel indem Fall '<your_mta_server_name>' muss in der 
Verarbeitungskette nach dem localhost vorkommen.

```
Received: from mail.siteos.de ([127.0.0.1])
   by localhost (mail.siteos.de [127.0.0.1]) (amavisd-new, port 10032)
   with ESMTP id qShazsGpJkmx; Sun, 24 Apr 2016 09:57:40 +0200 (CEST)
Received: from localhost (localhost.siteos.de [127.0.0.1])
   by mail.siteos.de (Postfix) with ESMTP id 2422F2CE002;
```

Siehe auch https://www.dnsexit.com/support/mailrelay/postfix.html

## Konfiguriere Postfix für nur-lokale Mail Delivery

Für einige Projekte ist es erforderlich, Mails versenden und empfangen 
zu können. Dies kann unter Windows auf einfache weise mittels Mercury 
unter XAMPP erfolgen. Unter Linux (hier: Fedora 26) kann man mit den 
folgenden Schritten einen nur-lokalen (d.h. nur auf localhost) Mailversand 
aufsetzen.

* Überprüfen, ob eine 'nur-SMTP' Lösung installiert ist (z.B. esmtp, nullmailer, etc.) und diese deinstallieren. (Unter Fedora 23 ist standardmäßig esmtp installiert und muss deinstalliert werden.)
* Postfix installieren.
* `/etc/postfix/main.cf` für lokalen Versand anpassen (s.u.)
* Nutzer und Gruppen anlegen und Berechtigungen setzen (s.u.)
* `/etc/aliases` anpassen und neu übersetzen (s.u.)
* Postfix auf automatisch starten setzen und starten: sudo systemctl enable postfix.service und dann sudo systemctl start postfix.service
* Konfiguration testen (s.u.) 

### Ergebnis

* Lokaler MTA (Mail Transfer Agent), der Mail nur lokal zustellt.
* Alle nicht-lokalen Mails landen bei einem bestimmten User.
* Dieser eine, konfigurierte User kann die nicht 'wirklich' versendeten Mails
  mittels der Commando Zeilen Tools mail bzw. mailx lesen.
* Gut für: Linux Desktop für die Entwicklung, bei denen man lokale Mails nicht 
  'wirklich' versenden möchte. 

### Konfiguration

#### `/etc/postfix/main.cf` anpassen

```
myhostname = <your_hostname>
mydomain = localhost  #or your domain if you have some configured on a system
myorigin = $mydomain
inet_interfaces = localhost
inet_protocols = all
mynetworks = 127.0.0.0/8
```

Noch mehr Details finden sich unter 
https://ask.fedoraproject.org/en/question/81052/local-user-mail/.

#### Nutzer und Gruppen anlegen und Berechtigungen setzen

Bemerkung: Dieser Abschnitt ist meist nicht nötig. Wahrscheinlich ist es 
besser, es erst einmal ohne diese Änderungen zu versuchen! Unter Ubuntu 
beispielsweise werden die Benutzergruppe/der User automatisch bei der 
Installation angelegt.

```
$ groupadd postdrop
$ useradd -M -l -d /bin/false postfix
$ postfix set-permissions
$ postfix check
$ postconf
```

#### `/etc/aliases` anpassen und neu übersetzen

Unten in /etc/aliases folgendes hinzufügen:

```
# Person who should get root's mail
root:           tpasch

# admin messages go to admin (tp)
admin:          tpasch
```

Danach die aliases Datenbank unbedingt mittels newaliases neu aufbauen.

Noch mehr Details finden sich unter http://netz10.de/2011/02/17/alias/

### Konfiguration testen

* Überprüfen, ob postfix läuft: `netstat -lt | grep smtp`
* Überprüfen, ob postfix als daemon läuft: `systemctl status postfix.service`, 
  falls Schwierigkeiten angezeigt werden mit `journalctl -xe` nachhaken.
* Test Mail schreiben und empfangen (s.u.)
* Bei Problemen die Mailqueue untersuchen: `mailq` (Details: 
  http://www.jeffgeerling.com/blogs/jeff-geerling/viewing-email-linux-using). 

#### Test Mail schreiben und empfangen

Am einfachsten geht das auf der Kommandozeile mit mailx (alternativen: mail 
und mutt). Dieses ist (meist) schon vorinstalliert. Mehr Details finden man 
unter http://tecadmin.net/ways-to-send-email-from-linux-command-line/.

Sollte man auf einen IMAP Server zum Mailemfang nicht verzichten können bzw. 
wollen, bietet sich dovecot an. (Das halte ich jedoch für Overkill - und 
habe es nicht ausprobiert).

##### Mails schreiben

```
$ mailx -s "test4" admin@localhost -r info@siteos.de <<EOF
vierter test
EOF
```

##### Mails empfangen

Einfach `mailx` eingeben. Die Parameter des Tools lässt man sich von man mailx 
erklären.

Oder Thunderbird (Mailabruf / eigenes Konto):

1. Datei -> Neu -> Andere Konten... -> Unix Mailspool (Movemail)
2. Dem Wizard folgen und dabei den Benutzernamen (der konfigurierte 
   Systembenutzer) und localhost eingeben 

Oder Thunderbird (pure Mailanzeige / stark eingeschränkte Nutzung):

1. In den "Local Folders" einen neuen Ordner anlegen, z.B. "System", und ggfs. 
   einen Unterordner, z.B. "<Username>"
2. Thunderbird schließen
3. Den neu angelegten Ordner im Profilordner lokalisieren, löschen und durch 
   einen Symlink auf /var/mail/<Username> ersetzen
4. Thunderbird starten 
