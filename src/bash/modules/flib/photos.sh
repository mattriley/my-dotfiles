#!/bin/bash

function flib.photos {

    local code_dir=${1:-$CODE_DIR}
    local photos_dir=${2:-$MY_PHOTOS}
    local node_version; node_version="$(cat "$code_dir/flib/.nvmrc")"
    cd "$photos_dir" && nvm use "$node_version"

}
