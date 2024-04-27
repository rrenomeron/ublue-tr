#!/bin/bash

set -oue pipefail
mkdir -p /tmp/chrome
echo "Downloading Google Signing Key"
curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome/linux_signing_key.pub

# First, delete all old keys; see https://github.com/rpm-software-management/rpm/issues/2577
# rpm -qa gpg-pubkey* --qf '%{NAME}-%{VERSION}-%{RELEASE} %{PACKAGER}\n' | grep 'linux-packages-keymaster@google.com' | \
#     sed 's/ .*$//' | xargs rpm -e
rpm --import /tmp/chrome/linux_signing_key.pub
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
EOF
rpm-ostree install google-chrome-stable