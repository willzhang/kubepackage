#!/bin/bash

set -e

path=`dirname $0`

#sed 's/^/export /' version.list > /etc/profile.d/version.sh
#sudo source /etc/profile.d/version.sh
echo "harbor_version：$harbor_version"
echo "kubernetes_version：$kubernetes_version"
docker run --rm --name=kubeadm-version wise2c/kubeadm-version:v${kubernetes_version} kubeadm config images list --kubernetes-version ${kubernetes_version} > ${path}/k8s-images-list.txt

for i in $(ls get_*.sh)
do
  bash $i
done
