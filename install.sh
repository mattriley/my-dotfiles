#!/bin/bash

function link {
    local source="$1"
    local dest="${2:-$1}"
    ln -sf "$(pwd)/src/$source" "$HOME/$dest"
}

function install {

    node "sort-vscode-settings.js"
    link "vscode-settings.json" "Library/Application Support/Code/User/settings.json"
    link ".gitconfig"    
    link ".bash_profile"
    link ".bashrc"    
    link ".zshrc"

}

install
echo "done"
