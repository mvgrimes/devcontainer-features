#!/bin/sh
set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="asdf"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"
VERSION=${VERSION:-"0.18.0"}
ARCH="arm64"

if [ ! -e "/usr/local/bin/asdf" ]; then
  url="https://github.com/asdf-vm/asdf/releases/download/v${VERSION}/asdf-v${VERSION}-linux-${ARCH}.tar.gz"
  echo "$FEATURE_ID install asdf from $url"

  curl -fsSL "$url" | tar xvz -C /usr/local/bin
fi

# Setup lifecycle scripts
echo "Scripts:"
ls
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
    echo "Created oncreate.sh lifecycle script"
fi
if [ -f postattch.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp postattch.sh "${LIFECYCLE_SCRIPTS_DIR}/postattch.sh"
    echo "Created postattch.sh lifecycle script"
fi
if [ -f postcreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp postcreate.sh "${LIFECYCLE_SCRIPTS_DIR}/postcreate.sh"
    echo "Created postcreate.sh lifecycle script"
fi
if [ -f poststart.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp poststart.sh "${LIFECYCLE_SCRIPTS_DIR}/poststart.sh"
    echo "Created poststart.sh lifecycle script"
fi
if [ -f updatecontent.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp updatecontent.sh "${LIFECYCLE_SCRIPTS_DIR} updatecontent.sh"
    echo "Created updatecontent.sh lifecycle script"
fi

echo "Finished installing $FEATURE_ID"
