#!/bin/bash

export DOTFILES_DIR="/Users/mattriley/Home/Code/my-dotfiles"

profile_common_loaded=0
if [ -f "$DOTFILES_DIR/src/bash/profile-common.sh" ]; then
    # shellcheck disable=SC1091
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

if [ -n "${BASH_VERSION:-}" ]; then
    if [ "${DOTFILES_BASH_PROFILE_LOADED:-0}" -eq 1 ]; then
        return 0
    fi

    export DOTFILES_BASH_PROFILE_LOADED=1
    export NODE_OPTIONS="--max_old_space_size=32768"
    export UV_THREADPOOL_SIZE=80

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
        dotfiles.print_shell_banner "$is_interactive" "bash"
    elif [ "$is_interactive" -eq 1 ]; then
        echo "Shell: bash"
    fi

    if [ "$profile_common_loaded" -eq 1 ]; then
        dotfiles.validate_dotfiles_dir "$is_interactive" || true
        dotfiles.export_profile_env
        dotfiles.setup_colors
        dotfiles.setup_bash_prompt_defaults
        dotfiles.load_modules
    else
        if [ -z "${DOTFILES_DIR:-}" ]; then
            if [ "$is_interactive" -eq 1 ]; then
                echo "Error: DOTFILES_DIR is not set" >&2
            fi
            export BASH_MODULES="${BASH_MODULES:-}"
        elif [ ! -d "$DOTFILES_DIR" ]; then
            if [ "$is_interactive" -eq 1 ]; then
                echo "Error: DOTFILES_DIR does not exist: $DOTFILES_DIR" >&2
            fi
            export BASH_MODULES="${BASH_MODULES:-}"
        else
            export BASH_MODULES="${BASH_MODULES:-$DOTFILES_DIR/src/bash/modules}"
        fi
    fi

    function t { npx -p "task-library" task "$@"; }

    if [ "$profile_common_loaded" -eq 1 ] && dotfiles.has_function "display.is-highres"; then
        display.is-highres && export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_HIGHRES"
        dotfiles.apply_prompt "$is_interactive"
        dotfiles.setup_node
    fi
fi
