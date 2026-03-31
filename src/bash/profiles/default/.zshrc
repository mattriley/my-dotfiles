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

if [ -z "${DOTFILES_DIR:-}" ]; then
    [ "$is_interactive" -eq 1 ] && echo "Error: DOTFILES_DIR is not set" >&2
elif [ ! -d "$DOTFILES_DIR" ]; then
    [ "$is_interactive" -eq 1 ] && echo "Error: DOTFILES_DIR does not exist: $DOTFILES_DIR" >&2
fi

# Load shared shell modules when the repo path is configured.
if [ -d "${BASH_MODULES:-}" ]; then
    setopt local_options null_glob
    for script_path in "$BASH_MODULES"/*/*.sh; do
        source "$script_path"
    done
fi

if whence node.nvm.setup >/dev/null 2>&1; then
    node.nvm.setup
fi

if whence node.nodenv.setup >/dev/null 2>&1; then
    node.nodenv.setup
fi

if [ "$is_interactive" -eq 1 ] && whence prompt.dev >/dev/null 2>&1; then
    prompt.dev
fi
