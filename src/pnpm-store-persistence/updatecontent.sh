#!/bin/sh
set -e

FEATURE_ID="pnpm-store-persistence"
LIFECYCLE="postattach.sh"

echo "$FEATURE_ID $LIFECYCLE"
echo "USER: $USER"
echo "env: "
env
