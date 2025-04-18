#!/usr/bin/bash
# Get the Accent Icons extension to allow Nautilus icons to follow the Gnome
# accent color

# See https://github.com/taiwbi/gnome-accent-directories

set -eou pipefail

ACCENT_ICONS_EXTENSION_VERSION=15
ACCENT_ICONS_EXTENSION_ID=accent-directories@taiwbi.com
curl -L https://extensions.gnome.org/extension-data/accent-directoriestaiwbi.com.v$ACCENT_ICONS_EXTENSION_VERSION.shell-extension.zip \
    > /tmp/accent-icons-extension.zip

EXTENSION_DIR=/usr/share/gnome-shell/extensions/$ACCENT_ICONS_EXTENSION_ID
mkdir -p $EXTENSION_DIR && cd $EXTENSION_DIR
unzip /tmp/accent-icons-extension.zip

# The metadata.json is stored in the zip with access mode 600 for some reason
chmod ugo+r $EXTENSION_DIR/metadata.json



