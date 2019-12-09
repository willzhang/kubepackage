#! /bin/bash

set -e

path=`dirname $0`
PKG_PATH=${path}/packages/etcd

image=k8s.gcr.io/etcd-amd64:${etcd_version}

docker pull ${image}
docker save ${image} > ${PKG_PATH}/etcd.tar
bzip2 -z --best ${PKG_PATH}/etcd.tar

echo "=== download cfssl tools ==="
export CFSSL_URL=https://pkg.cfssl.org/R1.2
curl -L -o cfssl ${CFSSL_URL}/cfssl_linux-amd64
curl -L -o cfssljson ${CFSSL_URL}/cfssljson_linux-amd64
curl -L -o cfssl-certinfo ${CFSSL_URL}/cfssl-certinfo_linux-amd64
chmod +x cfssl cfssljson cfssl-certinfo
tar zcvf ${PKG_PATH}/cfssl-tools.tar.gz cfssl cfssl-certinfo cfssljson
echo "=== cfssl tools is download successfully ==="