#!/bin/sh
set -e

echo "USER: $USER"
echo "containerUser: $_CONTAINER_USER"
echo "containerUser home: $_CONTAINER_USER_HOME"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="secure-node-user"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"


echo "Secure node user"
rm -f /etc/sudoers.d/node


# Setup lifecycle scripts
echo "Scripts:"
ls
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
    cp updatecontent.sh "${LIFECYCLE_SCRIPTS_DIR}/updatecontent.sh"
    echo "Created updatecontent.sh lifecycle script"
fi

echo "Finished installing $FEATURE_ID"

