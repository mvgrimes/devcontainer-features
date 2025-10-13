#!/bin/sh
set -e

FEATURE_ID="claude-code-persistence"
VOLUME_MOUNT="/dc/claude-code"
LIFECYCLE="oncreate.sh"

# if the user is not root, chown volume to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running $FEATURE_ID $LIFECYCLE for user $USER"
    sudo chown -R "$USER:$USER" "$VOLUME_MOUNT"
fi
