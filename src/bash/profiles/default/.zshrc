#!/bin/zsh

# Ensure PATH/etc from the shared bashrc is available in zsh.
source "$HOME/.bashrc"

# Intentionally do not source `.bash_profile` here:
# it is bash-specific and returns immediately under zsh.

case $- in
    *i*) is_interactive=1 ;;
    *) is_interactive=0 ;;
esac

[ "$is_interactive" -eq 1 ] && echo "Shell: zsh"

# Load shared git aliases when the repo path is configured.
if [ -n "${DOTFILES_DIR:-}" ] && [ -f "$DOTFILES_DIR/src/bash/modules/git/aliases.sh" ]; then
    source "$DOTFILES_DIR/src/bash/modules/git/aliases.sh"
fi

# Initialize nvm (if installed) so `node`/`npm` match your desired version in zsh.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Initialize nodenv (if installed) so `node`/`npm` match your desired version in zsh.
command -v nodenv >/dev/null 2>&1 && eval "$(nodenv init -)"
