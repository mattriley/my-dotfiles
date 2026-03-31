#!/bin/zsh

# Ensure PATH/etc from the shared bashrc is available in zsh.
source "$HOME/.bashrc"

# Intentionally do not source `.bash_profile` here:
# it is bash-specific and returns immediately under zsh.

echo "Shell: zsh"

# Initialize nvm (if installed) so `node`/`npm` match your desired version in zsh.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Initialize nodenv (if installed) so `node`/`npm` match your desired version in zsh.
command -v nodenv >/dev/null 2>&1 && eval "$(nodenv init -)"
