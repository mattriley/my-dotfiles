#!/bin/bash

function flib.photos {

    local profile=${1:-$PHOTOS_DEFAULT_PROFILE}
    local photos_dir="$PHOTOS_PARTIAL_PATH$profile"
    local node_version_file="$CODE_DIR/flib/.node-version"

    if [ -f "$node_version_file" ]; then
        export NODENV_VERSION
        NODENV_VERSION="$(cat "$node_version_file")"
    fi

    cd "$photos_dir" || return 1

}
