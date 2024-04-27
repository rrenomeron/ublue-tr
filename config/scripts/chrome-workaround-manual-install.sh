#!/bin/bash

# The only way I've gotten the Google Chrome RPM to install is by manually layering it with rpm-ostree.
# However, this keeps the version pinned. It seems rpm-ostree can't seem to figure out how to handle downloading
# Chrome from a repo, either because of a dodgy signature or some other oddball bug.  So instead, we'll download
# the latest RPM when we build the image, manually verify it build time, and leave it there to be dealt with at runtime.
# We'll probably have to reboot more than we need to, but at least we'll have Chrome running without the flatpak issues.

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
rpm -qp --queryformat '%{VERSION}' /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm \
    > /usr/share/ublue-tr/chrome-workarounds/google-chrome-current-version

echo "Verified Google Chrome RPM installed for manual layering"

