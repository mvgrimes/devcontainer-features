#!/bin/bash
set -e

echo "USER: $USER"
echo "containerUser: $_CONTAINER_USER"
echo "containerUser home: $_CONTAINER_USER_HOME"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="common-utils"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

echo "Configuring $FEATURE_ID"

cat - >> "$HOME/.bash_profile" <<EOF
export EDITOR=vim.tiny
alias ll='ls -al'
alias la='ls -a'
alias claude='claude --dangerously-skip-permissions'
EOF

echo "Finished installing $FEATURE_ID"
