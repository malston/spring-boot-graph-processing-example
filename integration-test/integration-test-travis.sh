#!/usr/bin/env bash
set -evx

function health_check() {
    HEALTH_CHECK_READY=
    while [ "$HEALTH_CHECK_READY" = "" ]; do
      echo "Creating container..."
      HEALTH_CHECK_READY=$(curl -s "$PUBLIC_IP:$1/$2"; echo);
      sleep 1
    done
}

# Export DOCKER public IP
echo "DOCKER_HOST=$DOCKER_HOST"
export PUBLIC_IP="$(echo \"$(echo $DOCKER_HOST)\"| \sed 's/tcp:\/\//http:\/\//g'| \sed 's/:[0-9]\{4,\}//g'| \sed 's/\"//g')"
echo "PUBLIC_IP=$PUBLIC_IP"

declare -a ports=("7474" "8761/health" "8888/admin/health")
# Do health checks on compose services
for i in "${ports[@]}"
do
   health_check "$i"
done
