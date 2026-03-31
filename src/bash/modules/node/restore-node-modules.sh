#!/bin/bash

if ! declare -f node.collect_extracted_node_modules_roots >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.restore_node_modules {

    local code_dir="${1:-$CODE_DIR}"
    local temp_dir="${2:-$TEMP_DIR}"
    local array=()

    node.collect_extracted_node_modules_roots "$temp_dir"

    [ "${#NODE_EXTRACTED_ROOTS[@]}" -gt 0 ] || { echo "Absent or ambiguous source directory"; return 1; }

    while IFS= read -r match; do
        array+=("$match")
    done < <(find "${NODE_EXTRACTED_ROOTS[@]}" -maxdepth 0 -type d)

    [[ ${#array[@]} -ne 1 ]] && echo "Absent or ambiguous source directory" && return 1

    local source_root="${array[0]}"

    node.collect_project_node_modules "$source_root"

    [ "${#NODE_MODULE_PATHS[@]}" -gt 0 ] || return 0

    find "${NODE_MODULE_PATHS[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' source; do
            local dest="$code_dir${source#"$source_root"}"
            dest=${dest//\/node_modules/}
            mv -v "$source" "$dest" && rmdir "$(dirname "$source")"
        done

    rmdir "$source_root"

}
