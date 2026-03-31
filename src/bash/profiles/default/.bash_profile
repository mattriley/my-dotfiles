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

if [ -f "$DOTFILES_DIR/src/bash/profile-common.sh" ]; then
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

# Local overrides (optional)
[ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"

export HOSTVARS="$HOME/.hostvars"
[ -f "$HOSTVARS" ] && source "$HOSTVARS"

export BASH_SILENCE_DEPRECATION_WARNING=1

export HOME_DIR="$HOME/Home"
export TEMP_DIR="$HOME_DIR/.temp"
export CODE_DIR="${CODE_DIR:-$HOME/Home/Code}"

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
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export ITERMOCIL_LAYOUT_HIGHRES="even-vertical"
export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"

# WARNING: Naming this VSCODE_EXTENSIONS will conflict and cause side effects with VSCode.
export MY_VSCODE_EXTENSIONS="bierner.markdown-mermaid | dbaeumer.vscode-eslint | dnicolson.binary-plist | marp-team.marp-vscode | timonwong.shellcheck | vscode-icons-team.vscode-icons"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export MY_PHOTOS="$HOME_DIR/Photos › Matt"
export PHOTOS_PARTIAL_PATH="$HOME_DIR/Photos › "
export PHOTOS_DEFAULT_PROFILE="Matt"
export SCREENCAPTURE_DIR="$HOME_DIR/Screenshots"

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

export DEV_PROMPT="\[\033[${BOLD}${GREEN}\]\w\[\033[${NORM}\]\[\033[${NORM}${BOLD}${BLUE}\]\$(prompt.git_branch)\[\033[${NORM}\] $ "

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
