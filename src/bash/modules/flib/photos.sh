#!/bin/bash

function flib.photos {

    local profile=${1:-$PHOTOS_DEFAULT_PROFILE}
    local photos_dir="$PHOTOS_PARTIAL_PATH$profile"
    local node_version; node_version="$(cat "$CODE_DIR/flib/.nvmrc")"
    cd "$photos_dir" && nvm use "$node_version"

}
