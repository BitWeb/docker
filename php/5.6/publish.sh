#!/usr/bin/env bash

TAG="bitweb/php:5.6"

docker build --no-cache -t "$TAG" .
IMAGE_ID=$(docker images --format "table {{.ID}}\t{{.Repository}}:{{.Tag}}" | grep "$TAG" | awk '{print $1}')

docker tag "$IMAGE_ID" "$TAG"
docker push "$TAG"
docker rmi "$IMAGE_ID"
