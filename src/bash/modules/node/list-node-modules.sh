#!/bin/bash

function node.list_node_modules {

    local code_dir=${1:-$CODE_DIR}
    local sources=()

    shopt -s nullglob
    sources=("$code_dir"/*/node_modules)
    shopt -u nullglob

    [ "${#sources[@]}" -gt 0 ] || return 0

    find "${sources[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' match; do 
            echo "$match"
        done

}
