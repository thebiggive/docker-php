# docker-php

A base PHP + Apache Docker image to support the Big Give's PHP + Slim apps, including:
 
 * [ClaimBot](https://github.com/thebiggive/claimbot)
 * [Identity](https://github.com/thebiggive/identity)
 * [Mailer](https://github.com/thebiggive/mailer)
 * [MatchBot](https://github.com/thebiggive/matchbot)

Currently using PHP 8.1.

## Manually build

For local testing:

    docker build -t thebiggive/php:local .

###

Dev build:

    docker build -t thebiggive/php:dev-local ./dev

As of April 2022 and PHP 8.1, phpdbg isn't bundled and Debian stable repos don't seem to have
a straightforward way to get it. So we now maintain and publish a `dev-8.1` tag with Xdebug enabled,
for e.g. CI test coverage. This means we can use the normal `8.1` tag for Production without
incurring significant extra overhead.

## Publish

* Push to main
* Wait for a successful daily [CircleCI build](.circleci/config.yml) build and push [to Docker Hub](https://hub.docker.com/r/thebiggive/php/builds/)
