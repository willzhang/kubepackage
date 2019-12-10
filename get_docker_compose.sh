#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages

curl -L https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m) -o ${PKG_PATH}/docker-compose
