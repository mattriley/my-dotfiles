#!/bin/bash

export DOTFILES_DIR="${DOTFILES_DIR:-/Users/mattriley/Home/Code/my-dotfiles}"

path_append_once() {
    local entry="$1"
    case ":$PATH:" in
        *":$entry:"*) ;;
        *) export PATH="$PATH:$entry" ;;
    esac
}

# Homebrew (brew)
path_append_once "/opt/homebrew/bin"

# Visual Studio Code (code)
path_append_once "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Local overrides (optional)
# shellcheck disable=SC1091
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
