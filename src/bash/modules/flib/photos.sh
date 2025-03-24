#!/bin/bash

function flib.photos {

    local profile=${1:-$PHOTOS_DEFAULT_PROFILE}
    local photos_dir="$PHOTOS_PARTIAL_PATH$profile"
    export NODENV_VERSION; NODENV_VERSION="$(cat "$CODE_DIR/flib/.node-version")"
    export NODE_OPTIONS=--max_old_space_size=8192
    cd "$photos_dir" || exit 1

}
