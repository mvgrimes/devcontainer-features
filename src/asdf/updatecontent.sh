#!/bin/sh
set -e

echo "containerUser: $USER"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"
echo "env: "
env

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="asdf"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

echo "Scripts:"
ls

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
    echo "Created oncreate.sh lifecycle script"
fi
if [ -f postattach.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp postattach.sh "${LIFECYCLE_SCRIPTS_DIR}/postattach.sh"
    echo "Created postattach.sh lifecycle script"
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
