#!/bin/bash

if ! declare -f node.collect_project_node_modules >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.list_node_modules {

    local code_dir=${1:-$CODE_DIR}

    node.collect_project_node_modules "$code_dir"

    [ "${#NODE_MODULE_PATHS[@]}" -gt 0 ] || return 0

    find "${NODE_MODULE_PATHS[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' match; do 
            echo "$match"
        done

}
