#!/bin/zsh

# Ensure PATH/etc from the shared bashrc is available in zsh.
source "$HOME/.bashrc"

# Intentionally do not source `.bash_profile` here:
# it is bash-specific and returns immediately under zsh.

if [ "${DOTFILES_ZSHRC_LOADED:-0}" -eq 1 ]; then
    return 0
fi

export DOTFILES_ZSHRC_LOADED=1

if [ -z "${DOTFILES_DIR:-}" ]; then
    case $- in
        *i*) echo "Error: DOTFILES_DIR is not set" >&2 ;;
    esac
elif [ ! -d "$DOTFILES_DIR" ]; then
    case $- in
        *i*) echo "Error: DOTFILES_DIR does not exist: $DOTFILES_DIR" >&2 ;;
    esac
fi

if [ -f "$DOTFILES_DIR/src/bash/profile-common.sh" ]; then
    source "$DOTFILES_DIR/src/bash/profile-common.sh"
fi

is_interactive=0
if whence dotfiles.is_interactive >/dev/null 2>&1; then
    if dotfiles.is_interactive; then
        is_interactive=1
    fi
else
    case $- in
        *i*) is_interactive=1 ;;
    esac
fi

if whence dotfiles.print_shell_banner >/dev/null 2>&1; then
    dotfiles.print_shell_banner "$is_interactive" "zsh"
elif [ "$is_interactive" -eq 1 ]; then
    echo "Shell: zsh"
fi

if whence dotfiles.load_modules >/dev/null 2>&1; then
    dotfiles.load_modules
fi

if whence dotfiles.setup_node >/dev/null 2>&1; then
    dotfiles.setup_node
fi

if whence dotfiles.apply_prompt >/dev/null 2>&1; then
    dotfiles.apply_prompt "$is_interactive"
fi
