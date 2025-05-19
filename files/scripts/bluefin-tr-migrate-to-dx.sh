#!/bin/bash


cat - >> /usr/lib/systemd/system/tr-migrate-to-dx.service << EOF
[Unit]
Description=Migrate system from discontinued bluefin-tr image to bluefin-dx-tr
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
Exec=bootc switch ghcr.io/rrenomeron/bluefin-dx-tr:gts

[Install]
WantedBy=multi-user.target
EOF

# Apparently this fails unless we run it in a snippet
# systemctl enable tr-migrate-to-dx.service