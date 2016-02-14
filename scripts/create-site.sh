#!/usr/bin/env bash

CONFFILE=$1.conf

BLOCK="<VirtualHost *:80>
    ServerName $1

    ServerAdmin webmaster@localhost
    DocumentRoot $2

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"

echo "$BLOCK" > "/etc/apache2/sites-available/$CONFFILE"
ln -fs "/etc/apache2/sites-available/$CONFFILE" "/etc/apache2/sites-enabled/$CONFFILE"

service apache2 restart > /dev/null