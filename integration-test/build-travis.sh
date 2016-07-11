#!/usr/bin/env bash
set -evx

export PUBLIC_IP="locahost"
export SPRING_NEO4J_HOST=$PUBLIC_IP
export SPRING_RABBITMQ_HOST=$PUBLIC_IP
export EUREKA_CLIENT_SERVICEURL_DEFAULTZONE="http://$PUBLIC_IP:8761/eureka/"
export SPRING_CLOUD_CONFIG_URI="http://$PUBLIC_IP:8888"

# Run tests and tear down
mvn clean install || die "'mvn clean install' failed" 1
