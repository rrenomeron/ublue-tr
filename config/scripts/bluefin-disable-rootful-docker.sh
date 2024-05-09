#!/bin/bash

if [ -n "$(systemctl list-unit-files | grep docker)" ]; then
    echo "Disabling Rootful Docker"
    systemctl disable docker.service docker.socket
fi
