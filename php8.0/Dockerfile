# Hopefully for a short while, we are copying the root `../Dockerfile` and
# building otherwise the same as 8.1. Delete this as soon as stable Mautic
# supports newer!
FROM php:8.0-apache-buster

RUN apt-get update \
 && apt-get install -y git-core libicu-dev libzip-dev zip \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

RUN docker-php-ext-install bcmath intl pcntl pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN pecl install redis && rm -rf /tmp/pear && docker-php-ext-enable redis

# TODO When upgrading to PHP 8.1+, we'll want to make the `mautic` site
# available there too (alongside `slim`).
COPY apache/mautic.conf /etc/apache2/sites-available/
COPY php/php.ini /usr/local/etc/php/

# Composer
# Pin to 2.4.1 for now because 2.4.2 introduced a permissions regression (or tightening) that
# doesn't work with our built-as-root(?) images, without per-app changes everywhere that
# Composer is used (e.g. multiple times in every entrypoint). This temporary pin seems like a
# reasonable step for now because it sounds like Composer are open to improving the behaviour
# here and there is active discussion this week (23/9/22).
# https://github.com/composer/composer/issues/11073
RUN curl -sS https://getcomposer.org/installer | php -- --version=2.4.1 --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite \
 && a2enmod remoteip \
 && a2dissite 000-default \
 && a2ensite mautic \
 && echo ServerName localhost >> /etc/apache2/apache2.conf

# Docker and multi-OS dev makes it hard to guarantee user matches for files inside app code, and
# it should typically live only on trusted partitions, so we bypass this security feature for the
# default app root. https://www.kenmuse.com/blog/avoiding-dubious-ownership-in-dev-containers/
RUN git config --global --add safe.directory /var/www/html
