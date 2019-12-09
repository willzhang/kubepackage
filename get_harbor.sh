#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages/harbor

curl -L https://storage.googleapis.com/harbor-releases/release-${harbor_version%.*}.0/harbor-offline-installer-v${harbor_version}.tgz \
    -o ${PKG_PATH}/harbor-offline-installer-v${harbor_version}.tgz
