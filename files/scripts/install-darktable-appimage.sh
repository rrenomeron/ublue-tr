#!/bin/bash
set -euo pipefail

DARKTABLE_VERSION=5.0.0
DARKTABLE_SHASUM="d0061ac5a345c473d98f04388197afaee48e61b638db576ae1c88700cb8855cd  Darktable-5.0.0-x86_64.AppImage"


curl -L \
    https://github.com/darktable-org/darktable/releases/download/release-$DARKTABLE_VERSION/Darktable-$DARKTABLE_VERSION-x86_64.AppImage \
    > /tmp/Darktable-$DARKTABLE_VERSION-x86_64.AppImage

cd /tmp
echo $DARKTABLE_SHASUM | sha256sum -c

chmod ugo+x ./Darktable-$DARKTABLE_VERSION-x86_64.AppImage
./Darktable-$DARKTABLE_VERSION-x86_64.AppImage --appimage-extract
cp ./Darktable-$DARKTABLE_VERSION-x86_64.AppImage /usr/bin
ln -s /usr/bin/darktable-$DARKTABLE_VERSION-x86_64.AppImage /usr/bin/darktable
cp squashfs-root/org.darktable.darktable.desktop /usr/share/applications

