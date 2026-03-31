#!/bin/bash

if ! declare -f node.collect_project_node_modules >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.extract_node_modules {

    local code_dir="${1:-$CODE_DIR}"
    local temp_dir="${2:-$TEMP_DIR}"
    local timestamp; timestamp=$(node -p "Date.now()")
    local dest_root="$temp_dir/${timestamp}_extracted_node_modules"

    node.collect_project_node_modules "$code_dir"

    [ "${#NODE_MODULE_PATHS[@]}" -gt 0 ] || return 0

    find "${NODE_MODULE_PATHS[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' source; do
            local dest="$dest_root${source#"$code_dir"}"
            dest=${dest//\/node_modules/}
            mkdir -p "$dest"
            mv -v "$source" "$dest"
        done

}
