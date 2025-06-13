#!/usr/bin/bash

# Get all the wallpapers from the Ubuntu release I used to run
# (mostly LTS, with the occasional just-before-the-LTS release)

set -euo pipefail

cd /tmp
# This takes far too long ...
# git clone https://git.launchpad.net/ubuntu/+source/ubuntu-wallpapers
# cd ubuntu-wallpapers
echo "Downloading Ubuntu wallpapers from launchpad.net"
wget https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/ubuntu-wallpapers/24.04.2/ubuntu-wallpapers_24.04.2.orig.tar.gz 
tar xvzf ubuntu-wallpapers_24.04.2.orig.tar.gz 
cd ubuntu-wallpapers_24.04.2.orig

UBUNTU_RELEASES="focal bionic xenial trusty precise lucid jammy"
rm -rf staging_area && mkdir staging_area
for UBUNTU_VERSION in $UBUNTU_RELEASES; do
    cat debian/ubuntu-wallpapers-$UBUNTU_VERSION.install | grep -v .xml | grep -v '^$' \
    | grep -v The_Land_of_Edonias | cut -d / -f 4 \
      >> files_to_copy
done
cat files_to_copy | xargs -I % cp % staging_area
mkdir /usr/share/backgrounds/ubuntu
cp staging_area/* /usr/share/backgrounds/ubuntu
echo "Additional disk space used in kb"
du /usr/share/backgrounds/ubuntu