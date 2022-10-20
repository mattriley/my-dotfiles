#!/bin/bash

function node.list_node_modules {

    local code_dir=${1:-$CODE_DIR}

    find "$code_dir"/*/node_modules -maxdepth 0 -type d -print0 | 
        while IFS= read -r -d '' match; do 
            echo "$match"
        done

}
