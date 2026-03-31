#!/bin/bash

function node.extract_node_modules {

    local code_dir=${1:-$CODE_DIR}
    local temp_dir=${2:-$TEMP_DIR}
    local timestamp; timestamp=$(node -p "Date.now()")
    local dest_root="$temp_dir/${timestamp}_extracted_node_modules"
    local sources=()

    shopt -s nullglob
    sources=("$code_dir"/*/node_modules)
    shopt -u nullglob

    [ "${#sources[@]}" -gt 0 ] || return 0

    find "${sources[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' source; do 
            local dest="$dest_root${source#"$code_dir"}"
            dest=${dest//\/node_modules/}
            mkdir -p "$dest"
            mv -v "$source" "$dest"
        done

}
