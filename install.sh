#!/bin/bash

function install {

    echo "Installing dotfiles..."

    local cwd; cwd=$(pwd)

    ln -sf "$cwd/src/.bash_profile" ~/.bash_profile
    ln -sf "$cwd/src/.bashrc" ~/.bashrc

    ln -sf "$cwd/src/.gitconfig" ~/.gitconfig
    ln -sf "$cwd/src/.zshrc" ~/.zshrc

    node "sort-vscode-settings.js"
    ln -sf "$cwd/src/vscode-settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

    echo "done."

}

install
