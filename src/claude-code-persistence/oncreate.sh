#!/bin/sh
set -e

FEATURE_ID="claude-code-persistence"
VOLUME_MOUNT="/dc/claude-code"
LIFECYCLE="oncreate.sh"

echo "$FEATURE_ID $LIFECYCLE"
echo "USER: $USER"
