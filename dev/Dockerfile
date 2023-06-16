FROM thebiggive/php:8.1

# CircleCI orb requires gpg for uploader validation
RUN apt-get update \
 && apt-get install -y gpg \
 && rm -rf /var/lib/apt/lists/* /var/cache/apk/*

# As of April 2022 and PHP 8.1, phpdbg isn't bundled and Debian stable repos don't seem to have
# a straightforward way to get it. So we now maintain and publish a `dev-8.1` tag with Xdebug enabled,
# for e.g. CI test coverage. This means we can use the normal `8.1` tag for Production without
# incurring significant extra overhead.
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
