#!/usr/bin/env bash
set -e

export PUBLIC_IP="locahost"
export SPRING_NEO4J_HOST=$PUBLIC_IP
export SPRING_RABBITMQ_HOST=$PUBLIC_IP
export EUREKA_CLIENT_SERVICEURL_DEFAULTZONE="http://$PUBLIC_IP:8761/eureka/"
export SPRING_CLOUD_CONFIG_URI="http://$PUBLIC_IP:8888"
export TWITTER_CRAWLER_HOST="$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' crawler)"
export TWITTER_CRAWLER_PORT="8080"
# Run integration tests
mvn clean test -Dtests=integration -Dserver.host=$TWITTER_CRAWLER_HOST -Dremote.server.port=$TWITTER_CRAWLER_PORT || die "'mvn clean test -Dtests=integration' failed" 1
# mvn clean install || die "'mvn clean install' failed" 1
