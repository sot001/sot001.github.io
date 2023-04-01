To rescan manually added files, use occ run as the web-server user;

`cd /usr/share/nginx/owncloud/`
`sudo -u www-data php occ files:scan --all`