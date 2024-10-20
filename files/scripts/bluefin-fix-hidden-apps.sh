#!/usr/bin/bash

set -eou pipefail

# Bluefin hides Gnome Terminal and System Monitor by default, since they
# ship replacements for them.  Those replacements don't work for us, so
# we bring back the OG apps
if [[ -f /usr/share/applications/org.gnome.Terminal.desktop ]]; then
    sed -i '/NoDisplay=true/d' /usr/share/applications/org.gnome.Terminal.desktop
fi
if [[ -f /usr/share/applications/gnome-system-monitor.desktop ]]; then
    sed -i '/NoDisplay=true/d'  /usr/share/applications/gnome-system-monitor.desktop
fi
if [[ -f /usr/share/applications/org.gnome.SystemMonitor.desktop ]]; then
    sed -i '/Hidden=true/d' /usr/share/applications/org.gnome.SystemMonitor.desktop
fi