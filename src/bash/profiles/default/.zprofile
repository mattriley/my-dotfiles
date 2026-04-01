#!/bin/zsh

if [ -z "${ZSH_VERSION:-}" ]; then
    return 0
fi

if [ "${DOTFILES_ZPROFILE_LOADED:-0}" -eq 1 ]; then
    return 0
fi

if [ ! -f "$HOME/.zshrc" ]; then
    echo "Error: missing required file: $HOME/.zshrc" >&2
    return 1
fi

export DOTFILES_ZPROFILE_LOADED=1

case $- in
    *i*) return 0 ;;
esac

source "$HOME/.zshrc"
