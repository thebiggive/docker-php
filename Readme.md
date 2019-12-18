# docker-php

A base PHP + Apache Docker image to support the Big Give's PHP + Slim apps - currently just
[MatchBot](https://github.com/thebiggive/matchbot).

Currently using PHP 7.4.

## Manually build

For local testing:

  docker build -t thebiggive/php .

## Publish

* Push to master
* Wait for a successful build [on Docker Hub](https://hub.docker.com/r/thebiggive/php/builds/)
