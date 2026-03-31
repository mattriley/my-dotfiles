#!/bin/bash

function node.list_node_modules {

    local code_dir="${1:-$CODE_DIR}"

    node.collect_project_node_modules "$code_dir"

    [ "${#NODE_MODULE_PATHS[@]}" -gt 0 ] || return 0

    find "${NODE_MODULE_PATHS[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' match; do
            echo "$match"
        done

}
