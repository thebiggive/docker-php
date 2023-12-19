# docker-php

A base PHP + Apache Docker image to support most of Big Give's PHP + Slim apps, including:
 
 * [ClaimBot](https://github.com/thebiggive/claimbot)
 * [Identity](https://github.com/thebiggive/identity)
 * [Mailer](https://github.com/thebiggive/mailer)
 * [MatchBot](https://github.com/thebiggive/matchbot)

Currently using PHP 8.2 by default.

PHP 8.1 is being used live but deprecated, with no new `-dev` tags.

PHP 8.3 is available for dev and live experiementation.

## Manually build

For local testing:

    docker build -t thebiggive/php:local .

###

Dev build:

    docker build -t thebiggive/php:dev-local ./dev

When we last checked in April 2022, phpdbg wasn't bundled and Debian stable repos didn't seem to have
a straightforward way to get it. So we maintain and publish `dev-8.2` etc. tags with Xdebug enabled,
for e.g. CI test coverage. This means we can use the normal `8.2` tag for Production without
incurring significant extra overhead.

Because we extend the dev tag from the non-Xdebug one, the latter must build successfully at least
once first.

## Publish

* Push to main
* Wait for a successful daily [CircleCI build](.circleci/config.yml) build and push [to Docker Hub](https://hub.docker.com/r/thebiggive/php/builds/)
