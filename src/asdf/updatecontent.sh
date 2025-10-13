#!/bin/sh
set -e

echo "containerUser: $USER"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"
echo "env: "
env
