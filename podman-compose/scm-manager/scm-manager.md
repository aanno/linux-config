# scm-manager

Forge for Git, Mercurial, and Subversion repositories in Java.
SCMs are supported via plugins.
You can get more plugins if you connect to the Cloudogu EcoSystem.

* https://scm-manager.org
* https://scm-manager.org/docs/3.8.x/en/installation/docker/
* https://github.com/scm-manager/scm-manager/tree/develop/scm-plugins
* https://platform.cloudogu.com/de/
* https://docs.cloudogu.com/de/usermanual/introduction/

## Details

* Process started:
  `java -cp /etc/scm:/opt/scm-server/lib/* -Djava.awt.headless=true sonia.scm.server.ScmServerDaemon`
* Config: `/etc/scm/config.yml`


`/opt/scm-server/bin/scm-server`

```sh
#!/bin/sh
exec java -cp "/etc/scm:/opt/scm-server/lib/*" \
  -Djava.awt.headless=true \
  $JAVA_OPTS $* \
  sonia.scm.server.ScmServerDaemon
```
