FROM php:8.1-apache

RUN apt-get update -qq \
 && apt-get install -y git-core libicu-dev libzip-dev zip \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

RUN docker-php-ext-install bcmath intl pcntl pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN pecl install redis && rm -rf /tmp/pear && docker-php-ext-enable redis

COPY apache/slim.conf /etc/apache2/sites-available/
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
 && a2ensite slim \
 && echo ServerName localhost >> /etc/apache2/apache2.conf
