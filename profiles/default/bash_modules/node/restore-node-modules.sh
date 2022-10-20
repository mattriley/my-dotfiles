#!/bin/bash

function node.restore_node_modules {

    local code_dir=${1:-$CODE_DIR}
    local array=()

    while IFS=  read -r match; do
        array+=("$match")
    done < <(find "$code_dir"/*_extracted_node_modules -maxdepth 0 -type d)

    [[ ${#array[@]} -ne 1 ]] && echo "Absent or ambiguous source directory" && return 1

    local source_root="${array[0]}"

    find "$source_root"/*/node_modules -maxdepth 0 -type d -print0 | 
        while IFS= read -r -d '' source; do 
            local dest="$code_dir${source#"$source_root"}"
            dest=${dest//\/node_modules/}
            mv -v "$source" "$dest"
        done

}
