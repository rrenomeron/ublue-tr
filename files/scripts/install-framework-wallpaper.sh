#!/usr/bin/bash

set -eou pipefail

curl -L https://downloads.frame.work/assets/framework-laptop12-wallpaper-pack.zip > /tmp/framework-wallpapers.zip
mkdir /usr/share/backgrounds/framework
cd /usr/share/backgrounds/framework
unzip /tmp/framework-wallpapers.zip