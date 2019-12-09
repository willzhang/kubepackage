#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages/kubernetes

kubernetes_repo=`cat ${path}/k8s-images-list.txt |grep kube-apiserver |awk -F '/' '{print $1}'`

flannel_repo="quay.io/coreos"

echo "=== pulling flannel image ==="
docker pull ${flannel_repo}/flannel:${flannel_version}-amd64
echo "=== flannel image is pulled successfully ==="

echo "=== saving flannel image ==="
docker save ${flannel_repo}/flannel:${flannel_version}-amd64 \
    > ${PKG_PATH}/flannel.tar
rm ${PKG_PATH}/flannel.tar.bz2 -f
bzip2 -z --best ${PKG_PATH}/flannel.tar
echo "=== flannel image is saved successfully ==="
