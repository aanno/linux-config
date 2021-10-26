# Install nextcloud as docker container

## Fedora

### `www-data` user

Nextcloud is Debian based. In this distribution, the user `www-data` is what 
`apache` is in Fedora: The user who owns the files that should be served.

The `www-data` user as id 33 in Debian. Hence, you need to add the following
line to `/etc/passwd`

```
www-data:x:33:48:Apache:/usr/share/httpd:/sbin/nologin
```

## Subdirectory install

I've have created the docker image 'aanno/nextcloud' for that. It needs the environment 
BASE_PATH set. Attention: The BASE_PATH will be used **at the first run only**.

A few additional tips:

* In you use http(s)://example.com/nextcloud set BASE_PATH to '/nextcloud'. The data 
  directory should than reside in '/var/www/html/nextcloud/data' as well.
* In `/var/www/html/nextcloud/config/config.php` the 'RewriteBase' line should
  read:
  ```
  'htaccess.RewriteBase' => '/nextcloud',
  ```
* In `/var/www.html/nextcloud/.htaccess` change the line
  ```
  RewriteBase /
  ```
  into
  ```
  RewriteBase /nextcloud
  ```
  
## `apps` and `custom_apps`

Having an `apps` and a `custom_apps` folder is a configuration trick that 
requires having the following lines in `config.php`:

```
  'apps_paths' =>
  array (
    0 =>
    array (
      'path' => '/var/www/html/nextcloud/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 =>
    array (
      'path' => '/var/www/html/nextcloud/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
```

## SELinux

* On fedora, `/var/log/audit/audit.log` is your friend
* It seems that my current way to have the persistent container data in `/home/dockeruser`
  is not the best thing to do. You should better work with (docker) _volumes_.

type=AVC msg=audit(1575217192.400:7775): avc:  denied  { write } for  pid=66900 comm="rsync" name="config" dev="dm-3" ino=3233962 scontext=system_u:system_r:container_t:s0:c754,c866 tcontext=unconfined_u:object_r:user_home_t:s0 tclass=dir permissive=0

This could happen is you don't use the 'z' option on directory/file docker mount. See http://jaormx.github.io/2018/selinux-and-docker-notes/ .

## Podman

* Fedora >= 31 (and RHEL >=8!) does _not_ support docker out of the box (you have to disable 
  sec groups v2 and fall back to sec groups v1 - see internet).
* For migration, see https://github.com/containers/libpod/blob/master/transfer.md
* For pod handling, see https://developers.redhat.com/blog/2019/01/15/podman-managing-containers-pods/
* However, podman has a few issues as well:
  - podman-compose does not work reliable. In addition, it is _not_ meant for production.
  - `/var/run/docker.sock` is no more. Hence the 'let's encrypt' has to be done different.
  - See https://github.com/portainer/portainer/issues/2991 and 
    https://www.projectatomic.io/blog/2018/05/podman-varlink/ for more information.

## Status and known problem

* `version.php` is _not_ in `nextcloud` folder but in `/var/www/html` and has to be copied to the right
  destination
* `nextcloud-docker.yml` is using some environment variables. Use 
  `dnc-compose.sh` instead of using `docker-compose` directly.
* No docker container for the database. I use this compose with an external 
  (mysql) db.
* A collabora container but it is _not_ (yet) used. Hence, comment it out!
* Redis container for file locking
* Solr container for nextant full text search. (Untested!)
* Uses the _stable_ version of nextcloud (currently 11.0.5).

### Known problems

#### Upgrade

* https://docs.nextcloud.com/server/latest/admin_manual/maintenance/upgrade.html

```bash
sudo -u www-data php occ maintenance:mode --on
sudo -u www-data php occ db:add-missing-columns
sudo -u www-data php occ db:add-missing-indices
```

#### File versioning

* https://docs.nextcloud.com/server/18/admin_manual/configuration_files/file_versioning.html

```bash
sudo -u www-data php occ help versions:cleanup
sudo -u www-data php occ help versions:expire
```

#### Trashbin

* https://docs.nextcloud.com/server/latest/user_manual/ar/files/deleted_file_management.html
* https://docs.nextcloud.com/server/18/admin_manual/configuration_files/file_versioning.html

```bash
sudo -u www-data php occ help trashbin:cleanup
sudo -u www-data php occ help trashbin:expire
```

#### nginx-proxy

* nginx-proxy 
  + is proxying a nextcloud-apache (no fpm)
  + can use HTTP 2, but nextcloud-apache is only HTTP 1.1
  + is unwrapping TLS (with let's encrypt support)

##### nginx-proxy and multiple services

nginx-proxy is currently unable to serve multiple subpaths. The issue is tracked by

* PR https://github.com/jwilder/nginx-proxy/pull/1083
* https://github.com/jwilder/nginx-proxy/pull/254

I only see one solution to work-around this: Make the apache of nextcloud 
serve multiple subpaths.

Further reading:

* https://stackoverflow.com/questions/39067295/docker-compose-external-container

#### Full text search

Full text search has changed (but I have not tackled this so far):

* https://github.com/nextcloud/fulltextsearch/wiki
* https://github.com/nextcloud/fulltextsearch/wiki/Basic-Installation

#### Cron

Some extension (like the news app) needs full cron support:

* https://docs.nextcloud.com/server/13/admin_manual/configuration_server/background_jobs_configuration.html#cron

### References

#### Nginx config

* https://gist.github.com/soheilhy/8b94347ff8336d971ad0
* https://www.keycdn.com/support/nginx-location-directive/
* http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_pass
* http://nginx.org/en/docs/http/ngx_http_upstream_conf_module.html
