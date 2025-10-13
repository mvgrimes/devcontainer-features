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

echo "Configuring $FEATURE_ID"

if [ -e ".tool-versions" ]; then
    while read -r plugin version; do
        echo "... adding plugin: $plugin"
        asdf plugin add "$plugin"
        echo "...i nstalling: $plugin $version"
        asdf install "$plugin" "$version"
    done < .tool-versions
else
    echo "No .tool-versions file found"
fi

echo "Finished installing $FEATURE_ID"
