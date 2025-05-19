#!/usr/bin/bash

function notify_user() {    
    logger $1
    echo $1
    user_name=$(loginctl list-sessions --output=json | jq -r '.[].user')
    uid=$(loginctl list-sessions --output=json | jq -r '.[].uid')
    xdg_runtime_path="/run/user/$uid"
    display_var=$(printenv DISPLAY)
    sudo -u "$user_name" DBUS_SESSION_BUS_ADDRESS=unix:path="$xdg_runtime_path"/bus DISPLAY="$display_var" notify-send "Google Chrome Update Service" "$1" --app-name="Google Chrome Update Service" -u NORMAL
}

function notify_failure() {
    notify_user $1
    exit 1
}

function wait_for_rpm_ostree() {
    RPM_OSTREE_BUSY=$(rpm-ostree status | grep "State: busy")
    while [ -n "$RPM_OSTREE_BUSY" ]; do
        notify_user "Waiting on rpm-ostree"
        sleep 300
        logger "Checking for rpm-ostree to be done"
        RPM_OSTREE_BUSY=$(rpm-ostree status | grep "State: busy")
    done
}

set -eou pipefail
wait_for_rpm_ostree
notify_user "This system is being migrated to bluefin-dx-tr.  You can continue working as the migration proceeds"
if ! bootc switch ghcr.io/rrenomeron/bluefin-dx-tr:gts; then
    notify_failure "Migration failed.  We will try again on next boot, or you can run "sudo bootc switch ghcr.io/rrenomeron/bluefin-dx-tr:gts" manually."
fi 

notify_user "Migration setup complete.  You will need to reboot your computer."
