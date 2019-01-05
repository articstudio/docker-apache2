FROM articstudio/apache2
MAINTAINER Artic <developers@articstudio.com>

ENV DEBIAN_FRONTEND noninteractive

# Update / Install dependencies
RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy apache2 software-properties-common supervisor; \
    apt-get clean; \
    apt-get autoremove; \
    && rm -fr /var/lib/apt/lists/*;

# Apache MODS
RUN a2enmod rewrite; \
    a2enmod headers; \
    a2enmod expires;

# Apache ENV variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Apache vhost config
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Port
EXPOSE 80

# Start apache
CMD /usr/sbin/apache2ctl -D FOREGROUND
