#!/bin/bash

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

#rpm -ivh  /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm
#rpm-ostree install /usr/share/ublue-tr/chrome-workarounds/google-chrome-stable_current_x86_64.rpm
echo "If you got this far, it's a success!"
