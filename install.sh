#!/bin/bash

NORM=$(tput sgr0)
BOLD=$(tput bold)

function install {
    local profile="${1:-default}"    
    local target="profiles/$profile"

    echo "Installing $BOLD$profile$NORM profile..."
    echo

    find "$target" -type f -print0 | 
        while IFS= read -r -d '' path; do 
            ln -sfv "$(pwd)/$path" "$HOME${path#"$target"}"
        done
}

install "$@"
echo
echo "done"
