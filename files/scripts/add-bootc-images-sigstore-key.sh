#!/bin/bash

# This adds the key from https://github.com/rrenomeron/bootc-images
# as a valid sigstore signing key for our image, so we can build
# from that repository too

set -eou pipefail

if [ "$IMAGE_NAME" != "ublue-tr" ]; then
    echo "Updating Container Policy for $IMAGE_NAME"
    jq  -f $(dirname "$0")/add-bootc-images-sigstore-key-$IMAGE_NAME.jq \
        /etc/containers/policy.json > /tmp/policy.json
    cp /tmp/policy.json /etc/containers/policy.json
else
    echo "Not updating container policy for $IMAGE_NAME"
fi