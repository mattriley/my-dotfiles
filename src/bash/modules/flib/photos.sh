#!/bin/bash

function flib.photos {

    local profile=${1:-$PHOTOS_DEFAULT_PROFILE}
    local photos_dir="$PHOTOS_PARTIAL_PATH$profile"
    export NODENV_VERSION; NODENV_VERSION="$(cat "$CODE_DIR/flib/.node-version")"
    cd "$photos_dir" || exit 1
    # local node_version; node_version="$(cat "$CODE_DIR/flib/.nvmrc")"
    # cd "$photos_dir" && nvm use "$node_version"

}
