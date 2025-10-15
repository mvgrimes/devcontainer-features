#!/bin/sh
set -e

echo "USER: $USER"
echo "containerUser: $_CONTAINER_USER"
echo "containerUser home: $_CONTAINER_USER_HOME"
echo "remoteUser: $_REMOTE_USER"
echo "remoteUser home: $_REMOTE_USER_HOME"

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="claude-code-persistence"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"
VOLUME_MOUNT="/dc/claude-code"

create_cache_dir() {
    if [ -d "$1" ]; then
        echo "Cache directory $1 already exists. Skip creation..."
    else
        echo "Create cache directory $1..."
        mkdir -p "$1"
    fi

    if [ -z "$2" ]; then
        echo "No username provided. Skip chown..."
    else
        echo "Change owner of $1 to $2..."
        chown -R "$2:$2" "$1"
    fi
}

create_symlink_file() {
    local local_file=$1
    local cache_file=$2
    local username=$3

    runuser -u "$username" -- mkdir -p "$(dirname "$local_file")"
    runuser -u "$username" -- mkdir -p "$(dirname "$cache_file")"

    # if the file we want to symlink already exists, the ln -s command will create a folder inside the existing folder
    if [ -e "$local_file" ] && [ ! -L "$local_file" ]; then
        echo "Moving existing $local_file to ${local_file}-old"
        mv "$local_file" "${local_file}-old"
    fi

    echo "Symlink $local_file to $cache_file for $username..."
    runuser -u "$username" -- ln -s "$cache_file" "$local_file"
}

create_cache_dir "$VOLUME_MOUNT" "${USERNAME}"
create_symlink_file "$_REMOTE_USER_HOME/.claude/.credentials.json" "$VOLUME_MOUNT/credentials.json" "${USERNAME}"

echo "Change owner of $VOLUME_MOUNT to $_REMOTE_USER..."
chown -R "$_REMOTE_USER:$_REMOTE_USER" "$VOLUME_MOUNT"

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
