FROM php:8.5-apache-bookworm

RUN apt-get update \
 && apt-get install -y git-core libicu-dev libzip-dev zip \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

RUN docker-php-ext-install bcmath intl pcntl pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN pecl install redis && rm -rf /tmp/pear && docker-php-ext-enable redis

COPY apache/security.conf /etc/apache2/conf-available/
COPY apache/slim.conf /etc/apache2/sites-available/
COPY php/php.ini /usr/local/etc/php/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod headers \
 && a2enmod rewrite \
 && a2enmod remoteip \
 && a2dissite 000-default \
 && a2ensite slim \
 && a2enconf security

# Docker and multi-OS dev makes it hard to guarantee user matches for files inside app code, and
# it should typically live only on trusted partitions, so we bypass this security feature for the
# default app root. https://www.kenmuse.com/blog/avoiding-dubious-ownership-in-dev-containers/
RUN git config --global --add safe.directory /var/www/html
