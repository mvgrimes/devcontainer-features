#!/bin/sh
set -e

FEATURE_ID="pnpm-store-persistence"
VOLUME_MOUNT="/dc/pnpm-store"
LIFECYCLE="oncreate.sh"

echo "$FEATURE_ID $LIFECYCLE"
echo "USER: $USER"

# set pnpm config (if it's installed)
if type pnpm > /dev/null 2>&1; then
    echo "Setting pnpm store location for $USER to $HOME/.pnpm-store"
    pnpm config set store-dir ~/.pnpm-store --global
else
    echo "WARN: pnpm is not installed! Please ensure pnpm is installed and in your PATH."
    echo "WARN: pnpm store location will not be set."
fi
