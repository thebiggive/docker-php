FROM thebiggive/php:8.2

# CircleCI orb requires gpg for uploader validation
RUN apt-get update \
 && apt-get install -y gpg \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
