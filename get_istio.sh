#! /bin/bash

set -e

path=`dirname $0`
PKG_PATH=${path}/packages/istio

curl -L -o ${PKG_PATH}/istio-$istio_version-origin.tar.gz https://github.com/istio/istio/releases/download/$istio_version/istio-$istio_version-linux.tar.gz

cd ${PKG_PATH}
tar zxf istio-$istio_version-origin.tar.gz
cat istio-$istio_version/install/kubernetes/istio-demo.yaml |grep "image:" |grep -v '\[\[' |grep -v '{' |awk -F':' '{print $2":"$3}' |awk -F "[\"\"]" '{print $2}' |awk '!a[$0]++{print}' > images-list.txt
#echo "istio/proxy_init:"${istio_version} >> images-list.txt
echo "ubuntu:xenial" >> images-list.txt

echo 'Images list for Istio:'
cat images-list.txt

for file in $(cat images-list.txt); do docker pull $file; done
echo 'Images pulled.'

docker save $(cat images-list.txt) -o istio-images-$istio_version.tar
echo 'Images saved.'
bzip2 -z --best istio-images-$istio_version.tar
echo 'Images are compressed as bzip format.'

rm -rf istio-$istio_version
