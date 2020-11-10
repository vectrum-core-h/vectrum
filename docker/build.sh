#!/usr/bin/env bash
set -eo pipefail

. ./.environment

DOCKER_FILE=${1:-"./from-binaries.dockerfile"}

docker build \
  --file $DOCKER_FILE \
  --tag $ORG/$REPO:temp \
  --compress --force-rm --no-cache \
  .

docker tag $ORG/$REPO:temp $ORG/$REPO:ubuntu-18.04-$VERSION
docker tag $ORG/$REPO:temp $ORG/$REPO:$VERSION
docker tag $ORG/$REPO:temp $ORG/$REPO:latest
