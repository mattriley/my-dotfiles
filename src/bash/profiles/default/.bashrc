#!/bin/bash

export DOTFILES_DIR="/Users/mattriley/Home/Code/my-dotfiles"

profile_common_loaded=0
if [ -f "$DOTFILES_DIR/src/bash/profile-common.sh" ]; then
    source "$DOTFILES_DIR/src/bash/profile-common.sh"
    profile_common_loaded=1
fi

# Homebrew (brew)
if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.path_append_once "/opt/homebrew/bin"
else
    export PATH="$PATH:/opt/homebrew/bin"
fi

# Visual Studio Code (code)
if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.path_append_once "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
else
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Local overrides (optional)
# shellcheck disable=SC1091
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
