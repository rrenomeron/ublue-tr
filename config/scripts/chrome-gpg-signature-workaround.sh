#!/bin/bash

set -oue pipefail
mkdir -p /tmp/chrome
echo "Downloading Google Signing Key"
curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome/linux_signing_key.pub

rpm --import /tmp/chrome/linux_signing_key.pub

echo "collecting information on where rpm put the key for future reference"
ls -l /etc/pki/rpm-gpg | grep -v fedora | grep -v rpmfusion 
rpm -qa gpg-pubkey* --qf '%{NAME}-%{VERSION}-%{RELEASE} %{PACKAGER}\n' | grep 'linux-packages-keymaster@google.com'

echo "Downloading and Verifying Google Chrome"
curl https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm > /tmp/chrome/google-chrome-stable_current_x86_64.rpm
rpm -K /tmp/chrome/google-chrome-stable_current_x86_64.rpm
rpm -ivh --relocate /opt=/usr/opt /tmp/chrome/google-chrome-stable_current_x86_64.rpm

echo "If you got this far, it's a success!"
