#!/usr/bin/bash

# This is a convenience script for building images locally.
# I'm sick of all the typing!

if [ $(command -v bluebuild) ]; then
    bluebuild build --build-driver=podman $1
else 
    echo "Bluebuild not installed, can't build!"
    exit 1
fi