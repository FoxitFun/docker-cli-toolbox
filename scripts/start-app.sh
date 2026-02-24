#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-up}"           # build | push | up | down
REGISTRY="${REGISTRY:-}" # np. registry.example.com
TAG="${TAG:-latest}"

#######################################
# Images definition
# format:
# name|dockerfile_path|build_context
#######################################

IMAGES=(
  "app-frontend|app/frontend/Dockerfile|app/frontend"
  "app-backend|app/djangorestapi/Dockerfile|app/djangorestapi"
  "app-nginx|app/nginx/Dockerfile|app/nginx"
)

#######################################
# Functions
#######################################

build_images() {
  for item in "${IMAGES[@]}"; do
    IFS="|" read -r name dockerfile context <<< "$item"

    full_name="${REGISTRY:+$REGISTRY/}$name:$TAG"

    echo "Building $full_name"
    docker build -t "$full_name" -f "$dockerfile" "$context"
  done
}

push_images() {
  for item in "${IMAGES[@]}"; do
    IFS="|" read -r name _ _ <<< "$item"
    full_name="${REGISTRY:+$REGISTRY/}$name:$TAG"

    echo "Pushing $full_name"
    docker push "$full_name"
  done
}

compose_up() {
  docker compose up -d
}

compose_down() {
  docker compose down
}

#######################################
# Execution
#######################################

case "$MODE" in
  build)
    build_images
    ;;
  push)
    build_images
    push_images
    ;;
  up)
    compose_up
    ;;
  down)
    compose_down
    ;;
  *)
    echo "Usage: $0 [build|push|up|down]"
    exit 1
    ;;
esac
