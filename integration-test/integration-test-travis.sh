#!/usr/bin/env bash
set -e

function health_check() {
    HEALTH_CHECK_READY=
    while [ "$HEALTH_CHECK_READY" = "" ]; do
      echo "Creating container..."
      HEALTH_CHECK_READY=$(curl -s "http://localhost:$1/$2"; echo);
      sleep 1
    done
}

declare -a ports=("7474" "8761/health" "8888/admin/health")
# Do health checks on compose services
for i in "${ports[@]}"
do
   health_check "$i"
done
