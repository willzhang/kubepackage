#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages/kubernetes

echo "=== downloading calico release package ==="
curl -L -o ${PKG_PATH}/calico-${calico_version}.tgz https://github.com/projectcalico/calico/releases/download/${calico_version}/release-${calico_version}.tgz
echo "=== calico release package is downloaded successfully ==="
tar zxf ${PKG_PATH}/calico-${calico_version}.tgz -C ${PKG_PATH}/
rm -f ${PKG_PATH}/calico-${calico_version}.tgz
mv ${PKG_PATH}/release-${calico_version} ${PKG_PATH}/calico
rm -rf ${PKG_PATH}/calico/bin
docker pull calico/pod2daemon-flexvol:${calico_version}
docker save calico/pod2daemon-flexvol:${calico_version} -o ${PKG_PATH}/calico/images/calico-pod2daemon-flexvol.tar
docker pull calico/ctl:${calico_version}
docker save calico/ctl:${calico_version} -o ${PKG_PATH}/calico/images/calico-ctl.tar
echo "=== Compressing calico images ==="
bzip2 -z --best ${PKG_PATH}/calico/images/calico-cni.tar
bzip2 -z --best ${PKG_PATH}/calico/images/calico-kube-controllers.tar
bzip2 -z --best ${PKG_PATH}/calico/images/calico-node.tar
bzip2 -z --best ${PKG_PATH}/calico/images/calico-pod2daemon-flexvol.tar
bzip2 -z --best ${PKG_PATH}/calico/images/calico-typha.tar
bzip2 -z --best ${PKG_PATH}/calico/images/calico-ctl.tar
echo "=== Calico images are compressed as bzip format successfully ==="
