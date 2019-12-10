#! /bin/bash

set -e

path=`dirname $0`

PKG_PATH=${path}/packages/contour

contour_repo="projectcontour"
contour_long_repo="docker.io/projectcontour"
contour_envoyproxy_repo="envoyproxy"
contour_envoyproxy_long_repo="docker.io/envoyproxy"
contour_demo_repo="gcr.io/kuar-demo"

echo "=== pulling contour and envoyproxy images ==="
docker pull ${contour_repo}/contour:${contour_version}
docker pull ${contour_envoyproxy_repo}/envoy:${contour_envoyproxy_version}
docker pull ${contour_demo_repo}/kuard-amd64:1
echo "=== contour and envoyproxy images are pulled successfully ==="

echo "=== saving contour and envoyproxy images ==="
docker save ${contour_repo}/contour:${contour_version} -o ${PKG_PATH}/contour.tar
docker save ${contour_envoyproxy_repo}/envoy:${contour_envoyproxy_version} -o ${PKG_PATH}/contour-envoyproxy.tar
docker save ${contour_demo_repo}/kuard-amd64:1 -o ${PKG_PATH}/contour-demo.tar
rm -f ${PKG_PATH}/contour.tar.bz2
rm -f ${PKG_PATH}/contour-envoyproxy.tar.bz2
rm -f ${PKG_PATH}/contour-demo.tar.bz2
bzip2 -z --best ${PKG_PATH}/contour.tar
bzip2 -z --best ${PKG_PATH}/contour-envoyproxy.tar
bzip2 -z --best ${PKG_PATH}/contour-demo.tar

echo "=== contour and envoyproxy images are saved successfully ==="
