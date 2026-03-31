#!/bin/bash

function node.restore_node_modules {

    local code_dir=${1:-$CODE_DIR}
    local temp_dir=${2:-$TEMP_DIR}
    local array=()
    local source_dirs=()

    shopt -s nullglob
    source_dirs=("$temp_dir"/*_extracted_node_modules)
    shopt -u nullglob

    [ "${#source_dirs[@]}" -gt 0 ] || { echo "Absent or ambiguous source directory"; return 1; }

    while IFS=  read -r match; do
        array+=("$match")
    done < <(find "${source_dirs[@]}" -maxdepth 0 -type d)

    [[ ${#array[@]} -ne 1 ]] && echo "Absent or ambiguous source directory" && return 1

    local source_root="${array[0]}"

    shopt -s nullglob
    source_dirs=("$source_root"/*/node_modules)
    shopt -u nullglob

    [ "${#source_dirs[@]}" -gt 0 ] || return 0

    find "${source_dirs[@]}" -maxdepth 0 -type d -print0 |
        while IFS= read -r -d '' source; do 
            local dest="$code_dir${source#"$source_root"}"
            dest=${dest//\/node_modules/}
            mv -v "$source" "$dest" && rmdir "$(dirname "$source")"
        done

    rmdir "$source_root"

}
