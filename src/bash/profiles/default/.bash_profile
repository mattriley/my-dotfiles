#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

# Only run under bash (zsh should not source this file, but keep it safe).
if [ -z "$BASH_VERSION" ]; then
    return 0
fi

if [ "${DOTFILES_BASH_PROFILE_LOADED:-0}" -eq 1 ]; then
    return 0
fi

if [ ! -f "$HOME/.bashrc" ]; then
    echo "Error: missing required file: $HOME/.bashrc" >&2
    return 1
fi

source "$HOME/.bashrc"

# Local overrides (optional)
[ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"

export HOSTVARS="$HOME/.hostvars"
[ -f "$HOSTVARS" ] && source "$HOSTVARS"
