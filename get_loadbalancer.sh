#! /bin/bash
set -e
path=`dirname $0`
PKG_PATH=${path}/packages/loadbalancer

echo "build wise2c/k8s-keepalived:${keepalived_version} image"
cd ${path}/keepalived
docker build -t willdockerhub/k8s-keepalived:${keepalived_version} .
cd ..
docker save willdockerhub/k8s-keepalived:${keepalived_version} -o ${PKG_PATH}/keepalived-${keepalived_version}.tar
bzip2 -z --best ${PKG_PATH}/keepalived-${keepalived_version}.tar

echo "pull haproxy:${haproxy_version} image"
docker pull haproxy:${haproxy_version}
docker save haproxy:${haproxy_version} -o ${PKG_PATH}/haproxy-${haproxy_version}.tar
bzip2 -z --best ${PKG_PATH}/haproxy-${haproxy_version}.tar
