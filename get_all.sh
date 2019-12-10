#!/bin/bash

set -e

path=`dirname $0`

docker run --rm --name=kubeadm-version wise2c/kubeadm-version:v${kubernetes_version} kubeadm config images list --kubernetes-version ${kubernetes_version} > ${path}/k8s-images-list.txt

for i in $(ls get_*.sh)
do
  bash $i
done
