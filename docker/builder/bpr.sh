#!/usr/bin/env bash
set -eo pipefail

. ./build.sh

docker push $ORG/$REPO:ubuntu-18.04-$VERSION
docker push $ORG/$REPO:$VERSION
docker push $ORG/$REPO:latest

docker rmi $ORG/$REPO:temp
docker rmi $ORG/$REPO:ubuntu-18.04-$VERSION
docker rmi $ORG/$REPO:$VERSION
#docker rmi $ORG/$REPO:latest
