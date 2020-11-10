#!/usr/bin/env bash
set -eo pipefail

docker build --no-cache .

docker-compose up
