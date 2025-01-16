#!/usr/bin/bash

# Get files from Bluefin that we'd also like to use for our uBlue image.
# Today, we just get the wallpaper. Tomorrow, who knows?

set -eou pipefail

# TODO: Respond to https://github.com/ublue-os/bluefin/pull/2076
get_wallpaper() {
    rsync -av system_files/silverblue/usr/share/gnome-background-properties \
              system_files/shared/usr/share/backgrounds \
              /usr/share
}

mkdir -p /tmp/bluefin
git clone https://github.com/ublue-os/bluefin /tmp/bluefin
cd /tmp/bluefin

get_wallpaper


