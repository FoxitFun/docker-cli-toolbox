#!/usr/bin/env bash

set -e

docker container prune -f
docker image prune -af
docker volume prune -f
docker network prune -f
docker builder prune -af

echo "Docker cleanup complete!"
