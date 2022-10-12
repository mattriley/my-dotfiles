#!/bin/bash

dotfiles="$(pwd)/dotfiles"

function link {
    local source="$1"
    local dest="${2:-$1}"
    ln -sf "$dotfiles/$source" "$HOME/$dest"
}

function install {
    node "./src/sort-vscode-settings.js" "$dotfiles/vscode-settings.json";
    link "vscode-settings.json" "Library/Application Support/Code/User/settings.json"
    link ".gitconfig"    
    link ".bash_profile"
    link ".bashrc"    
    link ".zshrc"
}

install
echo "done"
