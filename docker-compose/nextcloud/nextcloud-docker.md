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
