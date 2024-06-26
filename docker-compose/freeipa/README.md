# FreeIPA

FreeIPA is a open source identity management solution from red hat. It includes:

* a LDAP server
* a web frontend
* a NTP daemon (?)
* a kerberos ticket server (?)
* a DNS server (optional)
* ...

I use it because it sets up an standard LDAP and allows its easy administration.

## Install

```
Setup complete

Next steps:
        1. You must make sure these network ports are open:
                TCP Ports:
                  * 80, 443: HTTP/HTTPS
                  * 389, 636: LDAP/LDAPS
                  * 88, 464: kerberos
                UDP Ports:
                  * 88, 464: kerberos
                  * 123: ntp

        2. You can now obtain a kerberos ticket using the command: 'kinit admin'
           This ticket will allow you to use the IPA tools (e.g., ipa user-add)
           and the web user interface.
        3. Kerberos requires time synchronization between clients
           and servers for correct operation. You should consider enabling ntpd.

Be sure to back up the CA certificates stored in /root/cacert.p12
These files are required to create replicas. The password for these
files is the Directory Manager password
```

## FreeIPA Ports

The Ports used could NOT be changed. This is the main reason to use the docker 
image. See https://superuser.com/questions/217487/the-best-ldap-browser-in-linux 
for details.

## LDAP

The LDAP component of freeIPA uses the RFC 2307bis scheme.

* https://www.freeipa.org/page/HowTo/LDAP

### LDAP Connection

* Hostname: ipa.redsnapper.fritz.box
* Port: 389 (STARTTLS is possible but not required)
* Port: 636 (ldaps, aka TLS)
* Base DN: dc=fritz,dc=box
* Authentication (optional):
  + Bind DN: uid=admin,cn=users,cn=accounts,dc=fritz,dc=box
  + Password: ???

#### Apache Directory Studio

To browse the LDAP, I recommend Apache Directory Studio (Eclipse based) from
http://directory.apache.org/studio/downloads.html . Use File -> LDAP Browser
-> LDAP Connection there to create a new browser.

#### IDEA LDAP Browser 

This IDEA LDAP Browser is known _not_ to work. Instead, I get the following 
error:

```
org.apache.directory.api.ldap.model.exception.LdapInvalidAttributeValueException: ERR_10006 Comparator OID nsSSLToken-oid is not a valid OID 
	at org.apache.directory.api.ldap.schema.loader.SchemaEntityFactory.getOid(SchemaEntityFactory.java:132)
	at org.apache.directory.api.ldap.schema.loader.SchemaEntityFactory.getAttributeType(SchemaEntityFactory.java:1003)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.addAttributeTypes(DefaultSchemaManager.java:861)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.addSchemaObjects(DefaultSchemaManager.java:307)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.load(DefaultSchemaManager.java:811)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.loadDepsFirst(DefaultSchemaManager.java:1297)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.loadWithDeps(DefaultSchemaManager.java:1215)
	at org.apache.directory.api.ldap.schema.manager.impl.DefaultSchemaManager.loadAllEnabled(DefaultSchemaManager.java:1096)
```

### Other LDAP Browsers

* https://www.ldap-account-manager.org/lamcms/
  + https://www.ldap-account-manager.org/static/doc/manual/ch04s03.html

### LDAP Authentication

* Owncloud/Nextcloud: https://www.freeipa.org/page/Owncloud_Authentication_against_FreeIPA
* Nextcloud: https://docs.nextcloud.com/server/13/admin_manual/configuration_user/user_auth_ldap.html
* Foreman: https://www.freeipa.org/page/Creating_a_binddn_for_Foreman

