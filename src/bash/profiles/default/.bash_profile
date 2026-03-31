#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

# Only run under bash (zsh should not source this file, but keep it safe).
if [ -z "$BASH_VERSION" ]; then
    return 0
fi

if [ "${DOTFILES_BASH_PROFILE_LOADED:-0}" -eq 1 ]; then
    return 0
fi

source "$HOME/.bashrc"
profile_common_loaded="${profile_common_loaded:-0}"

if [ "$profile_common_loaded" -eq 0 ]; then
    is_interactive=0
    case $- in
        *i*) is_interactive=1 ;;
    esac

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

# Local overrides (optional)
if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.source_optional_file "$HOME/.bash_profile.local"
else
    [ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"
fi

export HOSTVARS="$HOME/.hostvars"
if [ "$profile_common_loaded" -eq 1 ]; then
    dotfiles.source_optional_file "$HOSTVARS"
else
    [ -f "$HOSTVARS" ] && source "$HOSTVARS"
fi
