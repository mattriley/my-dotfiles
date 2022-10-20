#!/bin/bash
# shellcheck disable=SC1091

function node.list_node_modules {

    find "$CODE_DIR"/*/node_modules -maxdepth 0 -type d -print0 | 
        while IFS= read -r -d '' source; do 
            echo "$source"
        done

}

