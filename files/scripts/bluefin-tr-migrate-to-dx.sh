#!/bin/bash


cat - >> /usr/lib/systemd/system/bluefin-tr-migrate-to-dx.service << EOF
[Unit]
Description=Migrate system from discontinued bluefin-tr image to bluefin-dx-tr
Wants=network-online.target
After=system-flatpak-setup.service

[Service]
Type=oneshot
Exec=bootc switch ghcr.io/rrenomeron/bluefin-dx-tr:gts

[Install]
WantedBy=multi-user.target
EOF

# Uncomment after May 11, 2025
systemctl enable bluefin-tr-migrate-to-dx.service