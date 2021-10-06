# docker-php

A base PHP + Apache Docker image to support the Big Give's PHP + Slim apps:
 
 * [Mailer](https://github.com/thebiggive/mailer)
 * [MatchBot](https://github.com/thebiggive/matchbot)

Currently using PHP 8.0.

## Manually build

For local testing:

    docker build -t thebiggive/php .

## Publish

* Push to main
* Wait for a successful daily [CircleCI build](.circleci/config.yml) build and push [to Docker Hub](https://hub.docker.com/r/thebiggive/php/builds/)
