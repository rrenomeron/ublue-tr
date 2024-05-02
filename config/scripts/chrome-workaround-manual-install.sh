#!/bin/bash

# Downloads and verifies the latest Google Chrome RPM, then saves it in the image so we can layer it at runtime.
#
# This seems to be the only way to get Chrome to install with a) validated signatures and b) with any kind of an
# update mechanism (even if it is mostly manual at teh moment).  Attempting to add Chrome to the image in the
# usual way (via the rpm-ostree module), and even by manually layering it in this step, always fail with no
# real explanation why (although forum posts seem to hint that it's related to 
# https://github.com/rpm-software-management/rpm/issues/2577).  We'd like to avoid using the Flatpak version,
# so unfortunately This Is The Way.  For now.

set -oue pipefail
mkdir -p /usr/share/ublue-tr/chrome-workarounds
mkdir -p /tmp/chrome-workarounds
echo "Downloading Google Signing Key"
curl https://dl.google.com/linux/linux_signing_key.pub > /usr/share/ublue-tr/chrome-workarounds/linux_signing_key.pub

rpm --import /usr/share/ublue-tr/chrome-workarounds/linux_signing_key.pub

echo "collecting information on where rpm put the key for future reference"
ls -l /etc/pki/rpm-gpg | grep -v fedora | grep -v rpmfusion 
rpm -qa gpg-pubkey* --qf '%{NAME}-%{VERSION}-%{RELEASE} %{PACKAGER}\n' | grep 'linux-packages-keymaster@google.com'

echo "Downloading Google Chrome"
curl https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm > /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm
echo "Verifying Google Chrome"
rpm -K /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm
# Save so we can verify the version later
TODAYS_CHROME_VERSION=$(rpm -qp --queryformat '%{VERSION}' /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm)
echo $TODAYS_CHROME_VERSION > /usr/share/ublue-tr/chrome-workarounds/google-chrome-current-version

echo "Verified Google Chrome RPM containing $TODAYS_CHROME_VERSION"
echo "Enabling Google Chrome Update Service"
systemctl enable -f google-chrome-update.service

# Someday this will work ...
# echo "Attempting layered install of Google Chrome"
# rpm-ostree install /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm

