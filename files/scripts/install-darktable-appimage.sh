#!/bin/bash
set -euo pipefail

DARKTABLE_VERSION=5.0.0
DARKTABLE_APPIMAGE=Darktable-$DARKTABLE_VERSION-x86_64.AppImage
DARKTABLE_SHASUM="d0061ac5a345c473d98f04388197afaee48e61b638db576ae1c88700cb8855cd  $DARKTABLE_APPIMAGE"


curl -L \
    https://github.com/darktable-org/darktable/releases/download/release-$DARKTABLE_VERSION/$DARKTABLE_APPIMAGE \
    > /tmp/$DARKTABLE_APPIMAGE

cd /tmp
echo $DARKTABLE_SHASUM | sha256sum -c

chmod ugo+x ./$DARKTABLE_APPIMAGE
./$DARKTABLE_APPIMAGE --appimage-extract
cp ./$DARKTABLE_APPIMAGE /usr/bin
ln -s /usr/bin/$DARKTABLE_APPIMAGE /usr/bin/darktable
cp squashfs-root/org.darktable.darktable.desktop /usr/share/applications
rsync -av squashfs-root/usr/share/icons/hicolor/ /usr/share/icons/hicolor

