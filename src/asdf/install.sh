#!/bin/sh
set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="asdf"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"
VERSION=${VERSION:-"0.18.0"}
ARCH="arm64"

if [ ! -e "/usr/local/bin/asdf" ]; then
  curl -fsSL https://github.com/asdf-vm/asdf/releases/download/${VERSION}/asdf-${VERSION}-linux-${ARCH}.tar.gz \
    | tar xvz -C /usr/local/bin
fi

echo "Finished installing $FEATURE_ID"
