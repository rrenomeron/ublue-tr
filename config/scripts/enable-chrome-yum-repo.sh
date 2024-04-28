#!/bin/bash

# Part of an attempt to add Google Chrome in the usual way.
echo "Fixing google-chrome yum repo"
sed -i '/enabled/d' /etc/yum.repos.d/google-chrome.repo 
echo "enabled=1" >> /etc/yum.repos.d/google-chrome.repo
First, delete all old keys; see https://github.com/rpm-software-management/rpm/issues/2577
GOOGLE_PUBKEYS_RPMS=$(rpm -qa gpg-pubkey* --qf '%{NAME}-%{VERSION}-%{RELEASE} %{PACKAGER}\n' | grep 'linux-packages-keymaster@google.com' | sed 's/ .*$//' | xargs rpm -e)
if [ -n $GOOGLE_PUBKEYS_RPMS ]; then
    echo "Removing pakcages $GOOGLE_PUBKEYS_RPMS"
    rpm -e $GOOGLE_PUBKEYS_RPMS
fi
echo "Downloading Google Signing Key"
curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/linux_signing_key.pub

rpm --import /tmp/linux_signing_key.pub
