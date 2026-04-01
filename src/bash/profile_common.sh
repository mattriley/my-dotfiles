#!/bin/bash
# shellcheck disable=SC2034

function dotfiles.is_interactive {
    case $- in
        *i*) return 0 ;;
        *) return 1 ;;
    esac
}

function dotfiles.path_append_once {
    local entry="$1"
    case ":$PATH:" in
        *":$entry:"*) ;;
        *) export PATH="$PATH:$entry" ;;
    esac
}

function dotfiles.has_function {
    local fn="$1"

    if [ -n "${ZSH_VERSION:-}" ]; then
        whence "$fn" >/dev/null 2>&1
    else
        declare -f "$fn" >/dev/null 2>&1
    fi
}

function dotfiles.validate_dotfiles_dir {
    local is_interactive="$1"

    if [ -z "${DOTFILES_DIR:-}" ]; then
        [ "$is_interactive" -eq 1 ] && echo "Error: DOTFILES_DIR is not set" >&2
        export BASH_MODULES="${BASH_MODULES:-}"
        return 1
    fi

    if [ ! -d "$DOTFILES_DIR" ]; then
        [ "$is_interactive" -eq 1 ] && echo "Error: DOTFILES_DIR does not exist: $DOTFILES_DIR" >&2
        export BASH_MODULES="${BASH_MODULES:-}"
        return 1
    fi

    export BASH_MODULES="${BASH_MODULES:-$DOTFILES_DIR/src/bash/modules}"
    return 0
}

function dotfiles.load_modules {
    [ -d "${BASH_MODULES:-}" ] || return 0

    if [ -n "${ZSH_VERSION:-}" ]; then
        setopt local_options null_glob
        local script_path
        for script_path in "$BASH_MODULES"/*/*.sh; do
                # shellcheck disable=SC1090
                source "$script_path"
        done
        return 0
    fi

    shopt -s nullglob
    local script_path
    for script_path in "$BASH_MODULES"/*/*.sh; do
        # shellcheck disable=SC1090
        source "$script_path"
    done
    shopt -u nullglob
}

function dotfiles.setup_node {
    dotfiles.has_function "node.nvm.setup" && node.nvm.setup
    dotfiles.has_function "node.nodenv.setup" && node.nodenv.setup
}

function dotfiles.apply_prompt {
    local is_interactive="$1"
    [ "$is_interactive" -eq 1 ] || return 0
    dotfiles.has_function "prompt.dev" && prompt.dev
}

function dotfiles.print_shell_banner {
    local is_interactive="$1"
    local shell_name="$2"
    [ "$is_interactive" -eq 1 ] && echo "Shell: $shell_name"
}

function dotfiles.export_profile_env {
    export NODE_OPTIONS="--max_old_space_size=32768"
    export UV_THREADPOOL_SIZE=80
    export BASH_SILENCE_DEPRECATION_WARNING=1
    dotfiles.source_optional_file "$DOTFILES_DIR/profiles/default/env.sh"
}

function dotfiles.setup_colors {
    if [ -n "${TERM:-}" ] && command -v tput >/dev/null 2>&1; then
        export NORM
        NORM=$(tput sgr0)
        export BOLD
        BOLD=$(tput bold)
        export RED
        RED=$(tput setaf 1)
        export GREEN
        GREEN=$(tput setaf 2)
        export YELLOW
        YELLOW=$(tput setaf 3)
        export BLUE
        BLUE=$(tput setaf 4)
        export MAGENTA
        MAGENTA=$(tput setaf 5)
    else
        export NORM=""
        export BOLD=""
        export RED=""
        export GREEN=""
        export YELLOW=""
        export BLUE=""
        export MAGENTA=""
    fi
}

function dotfiles.setup_bash_prompt_defaults {
    export DEV_PROMPT="\[\033[${BOLD}${GREEN}\]\w\[\033[${NORM}\]\[\033[${NORM}${BOLD}${BLUE}\]\$(prompt.git_branch)\[\033[${NORM}\] $ "
}

function dotfiles.source_optional_file {
    local path="$1"
    # shellcheck disable=SC1090
    [ -f "$path" ] && source "$path"
}
