FROM php:7.3-apache

RUN apt-get update -qq  \
 && apt-get install -y git-core libzip-dev \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install bcmath pdo_mysql zip
RUN docker-php-ext-enable opcache

RUN pecl install redis && rm -rf /tmp/pear && docker-php-ext-enable redis

COPY apache/slim.conf /etc/apache2/sites-available/
COPY php/php.ini /usr/local/etc/php/

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Composer parallel installs
RUN composer global require hirak/prestissimo

RUN a2enmod rewrite \
 && a2enmod remoteip \
 && a2dissite 000-default \
 && a2ensite slim \
 && echo ServerName localhost >> /etc/apache2/apache2.conf
