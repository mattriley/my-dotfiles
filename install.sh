#!/bin/bash

function install {
    targets="targets"
    node "src/sort-vscode-settings.js" "$targets/Library/Application Support/Code/User/settings.json";
    find "$targets" -type f -print0 | 
        while IFS= read -r -d '' path; do 
            echo "$(pwd)/$path" "$HOME/${path#*/}"
            ln -sf "$(pwd)/$path" "$HOME/${path#*/}"
        done
}

install
echo "done"
