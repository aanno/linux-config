root@blacksnapper:/home/tpasch/Downloads/mariadb# dnf remove mariadb-server
Abhängigkeiten sind aufgelöst.
==============================================================================================================
 Paket                                    Architektur     Version                     Paketquelle       Größe
==============================================================================================================
Entfernen:
 mariadb-server                           x86_64          3:10.11.8-3.fc40            @updates           77 M
Abhängige Pakete werden entfernt:
 akonadi-server-mysql                     x86_64          24.05.0-1.fc40              @updates          3.2 k
Nicht benötigte Abhängigkeiten werden entfernt:
 mariadb                                  x86_64          3:10.11.8-3.fc40            @updates           22 M
 mariadb-backup                           x86_64          3:10.11.8-3.fc40            @updates           22 M
 mariadb-common                           noarch          3:10.11.8-3.fc40            @updates          186 k
 mariadb-cracklib-password-check          x86_64          3:10.11.8-3.fc40            @updates           17 k
 mariadb-errmsg                           noarch          3:10.11.8-3.fc40            @updates          3.0 M
 mariadb-gssapi-server                    x86_64          3:10.11.8-3.fc40            @updates           20 k
 mariadb-server-utils                     x86_64          3:10.11.8-3.fc40            @updates          1.4 M
 perl-DBD-MariaDB                         x86_64          1.23-4.fc40                 @fedora           381 k
 perl-DBI                                 x86_64          1.643-22.fc40               @fedora           1.8 M

Transaktionszusammenfassung
==============================================================================================================
Entfernen  11 Pakete



Install:

```
 mv opt/owntone/make-it-longer/mariadb-build/*.rpm ~/Downloads/mariadb/
#
dnf install ./MariaDB-common-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-shared-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-client-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-server-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-connect-engine-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-backup-11.1.6-1.fc40.x86_64.rpm
dnf install ./MariaDB-cracklib-password-check-11.1.6-1.fc40.x86_64.rpm  ./MariaDB-gssapi-server-11.1.6-1.fc40.x86_64.rpm
# fixme: also installs debuginfo
dnf install ./MariaDB-provider-*.rpm
#
dnf install akonadi-server-mysql
```


```
# ls *compat*
MariaDB-client-compat-11.1.6-1.fc40.noarch.rpm
MariaDB-server-compat-11.1.6-1.fc40.noarch.rpm
```
