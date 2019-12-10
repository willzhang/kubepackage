#! /bin/bash
set -e
path=`dirname $0`
PKG_PATH=${path}/packages

echo "pull willdockerhub/k8s-keepalived:${keepalived_version} image"

docker pull willdockerhub/k8s-keepalived:${keepalived_version}
docker save willdockerhub/k8s-keepalived:${keepalived_version} -o ${PKG_PATH}/keepalived-${keepalived_version}.tar
bzip2 -z --best ${PKG_PATH}/keepalived-${keepalived_version}.tar

echo "pull haproxy:${haproxy_version} image"
docker pull haproxy:${haproxy_version}
docker save haproxy:${haproxy_version} -o ${PKG_PATH}/haproxy-${haproxy_version}.tar
bzip2 -z --best ${PKG_PATH}/haproxy-${haproxy_version}.tar
