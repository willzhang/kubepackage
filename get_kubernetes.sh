#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages/kubernetes

mkdir -p ${PKG_PATH}

docker run --rm --name=kubeadm-version wise2c/kubeadm-version:v${kubernetes_version} kubeadm config images list --kubernetes-version ${kubernetes_version} > ${path}/k8s-images-list.txt

echo "=== pulling kubernetes images ==="
for IMAGES in $(cat ${path}/k8s-images-list.txt |grep -v etcd); do
  docker pull ${IMAGES}
done
echo "=== kubernetes images are pulled successfully ==="

echo "=== saving kubernetes images ==="
docker save $(cat ${path}/k8s-images-list.txt |grep -v etcd) -o ${PKG_PATH}/k8s.tar
rm ${PKG_PATH}/k8s.tar.bz2 -f
bzip2 -z --best ${PKG_PATH}/k8s.tar
echo "=== kubernetes images are saved successfully ==="
