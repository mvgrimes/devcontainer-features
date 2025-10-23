#!/bin/sh
set -e

echo "USER: $USER"
echo "containerUser: $_CONTAINER_USER"
echo "containerUser home: $_CONTAINER_USER_HOME"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="asdf"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

echo "Configuring $FEATURE_ID"

# Install plugins and used tool versions
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

# Add asdf shims to path
echo 'export PATH=$HOME/.asdf/shims:$PATH' >> $HOME/.bash_profile

echo "Finished installing $FEATURE_ID"
