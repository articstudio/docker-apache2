#!/bin/bash

bash /tmp/init/init.sh >>/var/log/startup.log 2>&1

mkdir /var/log/supervisor /var/log/apache2

exec /usr/bin/supervisord