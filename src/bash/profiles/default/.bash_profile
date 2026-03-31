#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

# Only run under bash (zsh should not source this file, but keep it safe).
if [ -z "$BASH_VERSION" ]; then
    return 0
fi

if [ "${DOTFILES_BASH_PROFILE_LOADED:-0}" -eq 1 ]; then
    return 0
fi

export DOTFILES_BASH_PROFILE_LOADED=1

export NODE_OPTIONS="--max_old_space_size=32768"
export UV_THREADPOOL_SIZE=80

source "$HOME/.bashrc"

if [ -n "${DOTFILES_DIR:-}" ] && [ -f "$DOTFILES_DIR/src/bash/profile-common.sh" ]; then
    source "$DOTFILES_DIR/src/bash/profile-common.sh"
fi

is_interactive=0
if declare -f dotfiles.is_interactive >/dev/null 2>&1; then
    if dotfiles.is_interactive; then
        is_interactive=1
    fi
else
    case $- in
        *i*) is_interactive=1 ;;
    esac
fi

if declare -f dotfiles.print_shell_banner >/dev/null 2>&1; then
    dotfiles.print_shell_banner "$is_interactive" "bash"
elif [ "$is_interactive" -eq 1 ]; then
    echo "Shell: bash"
fi

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
if declare -f dotfiles.export_profile_env >/dev/null 2>&1; then
    dotfiles.export_profile_env
fi

if declare -f dotfiles.setup_colors >/dev/null 2>&1; then
    dotfiles.setup_colors
fi

if declare -f dotfiles.setup_bash_prompt_defaults >/dev/null 2>&1; then
    dotfiles.setup_bash_prompt_defaults
fi

# Local overrides (optional)
if declare -f dotfiles.source_optional_file >/dev/null 2>&1; then
    dotfiles.source_optional_file "$HOME/.bash_profile.local"
else
    [ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"
fi

export HOSTVARS="$HOME/.hostvars"
if declare -f dotfiles.source_optional_file >/dev/null 2>&1; then
    dotfiles.source_optional_file "$HOSTVARS"
else
    [ -f "$HOSTVARS" ] && source "$HOSTVARS"
fi

if declare -f dotfiles.load_modules >/dev/null 2>&1; then
    dotfiles.load_modules
fi

function t { npx -p "task-library" task "$@"; }

if declare -f dotfiles.has_function >/dev/null 2>&1 && dotfiles.has_function "display.is-highres"; then
    display.is-highres && ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_HIGHRES"
fi

if declare -f dotfiles.apply_prompt >/dev/null 2>&1; then
    dotfiles.apply_prompt "$is_interactive"
fi

if declare -f dotfiles.setup_node >/dev/null 2>&1; then
    dotfiles.setup_node
fi
