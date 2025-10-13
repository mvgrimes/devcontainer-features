#!/bin/sh
set -e

FEATURE_ID="pnpm-store-persistence"
VOLUME_MOUNT="/dc/pnpm-store"
LIFECYCLE="oncreate.sh"

# set pnpm config (if it's installed)
if type pnpm >/dev/null 2>&1; then
    echo "Setting pnpm store location to $_REMOTE_USER_HOME/.pnpm-store"
    pnpm config set store-dir ~/.pnpm-store --global
else
    echo "WARN: pnpm is not installed! Please ensure pnpm is installed and in your PATH."
    echo "WARN: pnpm store location will not be set."
fi

# if the user is not root, chown volume to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running $FEATURE_ID $LIFECYCLE for user $USER"
    sudo chown -R "$USER:$USER" "$VOLUME_MOUNT"
fi
