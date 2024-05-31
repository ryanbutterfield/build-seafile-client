#!/bin/bash

set -e

export VERSION=9.0.5
export PREFIX=/usr
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="$PREFIX/bin:$PATH"

cd /data

rm -rf *

wget --content-disposition -nc https://github.com/haiwen/libsearpc/archive/v3.2-latest.tar.gz
wget --content-disposition -nc https://github.com/haiwen/seafile/archive/v${VERSION}.tar.gz
wget --content-disposition -nc https://github.com/haiwen/seafile-client/archive/v${VERSION}.tar.gz

tar xfv libsearpc-3.2-latest.tar.gz
tar xfv seafile-${VERSION}.tar.gz
tar xfv seafile-client-${VERSION}.tar.gz

cp libsearpc-3.2-latest.tar.gz libsearpc1_3.2.0.orig.tar.gz
cp seafile-${VERSION}.tar.gz seafile-daemon_${VERSION}.orig.tar.gz
cp seafile-client-${VERSION}.tar.gz seafile-gui_${VERSION}.orig.tar.gz

cd /data/libsearpc-3.2-latest
cp /libsearcpc-fix-pkgconfig-paths.patch debian/patches/fix-pkgconfig-paths.patch
dpkg-buildpackage -us -uc

cd /data
dpkg -i *.deb

cd /data/seafile-${VERSION}
cp /seafile-fix-pkgconfig-paths.patch debian/patches/fix-pkgconfig-paths.patch
dpkg-buildpackage -us -uc

cd /data
dpkg -i *.deb

cd /data/seafile-client-${VERSION}
dpkg-buildpackage -us -uc

cd /data
rm *dbg*.deb
rm *dev*.deb
mv *.deb /tmp
rm -rf *
mv /tmp/*.deb .

echo 'Done!'