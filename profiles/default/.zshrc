#!/bin/zsh

# Ensure PATH/etc from the shared bashrc is available in zsh.
source "$HOME/.bashrc"

# Intentionally do not source `.bash_profile` here:
# it is bash-specific and returns immediately under zsh.

if [ "${DOTFILES_ZSHRC_LOADED:-0}" -eq 1 ]; then
    return 0
fi

export DOTFILES_ZSHRC_LOADED=1

profile_common_loaded=0
if [ -f "$DOTFILES_DIR/src/bash/profile_common.sh" ]; then
    source "$DOTFILES_DIR/src/bash/profile_common.sh"
    profile_common_loaded=1
fi

is_interactive=0
if [ "$profile_common_loaded" -eq 1 ]; then
    if dotfiles.is_interactive; then
        is_interactive=1
    fi
else
    case $- in
        *i*) is_interactive=1 ;;
    esac
fi

if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.validate_dotfiles_dir "$is_interactive" || true
else
    if [ -z "${DOTFILES_DIR:-}" ]; then
        if [ "$is_interactive" -eq 1 ]; then
            echo "Error: DOTFILES_DIR is not set" >&2
        fi
    elif [ ! -d "$DOTFILES_DIR" ]; then
        if [ "$is_interactive" -eq 1 ]; then
            echo "Error: DOTFILES_DIR does not exist: $DOTFILES_DIR" >&2
        fi
    else
        export BASH_MODULES="${BASH_MODULES:-$DOTFILES_DIR/src/bash/modules}"
    fi
fi

if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.print_shell_banner "$is_interactive" "zsh"
elif [ "$is_interactive" -eq 1 ]; then
    echo "Shell: zsh"
fi

if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.load_modules
fi

if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.setup_node
fi

if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.apply_prompt "$is_interactive"
fi
