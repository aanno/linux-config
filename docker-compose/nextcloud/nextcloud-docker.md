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

## Status and known problem

* `nextcloud-docker.yml` is using some environment variables. Use 
  `dnc-compose.sh` instead of using `docker-compose` directly.
* No docker container for the database. I use this compose with an external 
  (mysql) db.
* A collabora container but it is _not_ (yet) used. Hence, comment it out!
* Redis container for file locking
* Solr container for nextant full text search.
* Uses the _stable_ version of nextcloud (currently 11.0.5).

### Known problems

#### nginx-proxy

* nginx-proxy 
  + is proxying a nextcloud-apache (no fpm)
  + can use HTTP 2, but nextcloud-apache is only HTTP 1.1
  + is unwrapping TLS (with let's encrypt support)

#### Full text search

Full text search has changed (but I have not tackled this so far):

* https://github.com/nextcloud/fulltextsearch/wiki
* https://github.com/nextcloud/fulltextsearch/wiki/Basic-Installation

#### Cron

Some extension (like the news app) needs full cron support:

* https://docs.nextcloud.com/server/13/admin_manual/configuration_server/background_jobs_configuration.html#cron
