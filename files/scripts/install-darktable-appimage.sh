#!/bin/bash
set -euo pipefail

DARKTABLE_VERSION=5.0.1
DARKTABLE_APPIMAGE=Darktable-$DARKTABLE_VERSION-x86_64.AppImage
DARKTABLE_SHASUM="881e4cfb79c473404f871d48bd60ed2d6234f90f71e33c1bdc033dafd6901f06  $DARKTABLE_APPIMAGE"


curl -L \
    https://github.com/darktable-org/darktable/releases/download/release-$DARKTABLE_VERSION/$DARKTABLE_APPIMAGE \
    > /tmp/$DARKTABLE_APPIMAGE

# Check the shasum.  For the sha256sum -c to work, we must be
# in the same directory as the target file
cd /tmp
echo $DARKTABLE_SHASUM | sha256sum -c

chmod ugo+x ./$DARKTABLE_APPIMAGE
./$DARKTABLE_APPIMAGE --appimage-extract
cp ./$DARKTABLE_APPIMAGE /usr/bin
ln -s /usr/bin/$DARKTABLE_APPIMAGE /usr/bin/darktable

# For some reason, even when we copy all the icons to the right place,
# GNOME won't find the icon.  So we hack the .desktop file to include
# the absolute path to the icon.
sed '/Icon=darktable/cIcon=/usr/share/icons/hicolor/scalable/apps/darktable.svg' \
    squashfs-root/org.darktable.darktable.desktop > /usr/share/applications/org.darktable.darktable.desktop
chmod ugo+x /usr/share/applications/org.darktable.darktable.desktop
rsync -av squashfs-root/usr/share/icons/hicolor/ /usr/share/icons/hicolor

