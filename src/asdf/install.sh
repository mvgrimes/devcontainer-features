#!/bin/sh
set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="asdf"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"
VERSION=${VERSION:-"0.18.0"}
ARCH="arm64"

if [ ! -e "/usr/local/bin/asdf" ]; then
  url="https://github.com/asdf-vm/asdf/releases/download/${VERSION}/asdf-v${VERSION}-linux-${ARCH}.tar.gz"
  echo "$FEATURE_ID install asdf from $url"

  curl -fsSL "$url" | tar xvz -C /usr/local/bin
fi

echo "Finished installing $FEATURE_ID"
