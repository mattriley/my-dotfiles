#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

# Only run under bash (zsh should not source this file, but keep it safe).
if [ -z "$BASH_VERSION" ]; then
    return 0
fi

echo "Shell: bash"

export NODE_OPTIONS="--max_old_space_size=32768"
export UV_THREADPOOL_SIZE=80

source "$HOME/.bashrc"

# Local overrides (optional)
[ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"

export HOSTVARS="$HOME/.hostvars"
[ -f "$HOSTVARS" ] && source "$HOSTVARS"

export BASH_SILENCE_DEPRECATION_WARNING=1

export HOME_DIR="$HOME/Home"
export TEMP_DIR="$HOME_DIR/.temp"
export CODE_DIR="$HOME_DIR/Code"
export BASH_MODULES="$CODE_DIR/my-dotfiles/src/bash/modules"
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

if [ -d "$BASH_MODULES" ]; then
    shopt -s nullglob
    for module_path in "$BASH_MODULES/"*; do
        for script_path in "$module_path/"*.sh; do
            source "$script_path"
        done
    done
    shopt -u nullglob
fi

function t { npx -p "task-library" task "$@"; }

if declare -f display.is-highres >/dev/null 2>&1; then
    display.is-highres && ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_HIGHRES"
fi

if declare -f prompt.dev >/dev/null 2>&1; then
    prompt.dev
fi

if declare -f node.nvm.setup >/dev/null 2>&1; then
    node.nvm.setup
fi

if declare -f node.nodenv.setup >/dev/null 2>&1; then
    node.nodenv.setup
fi
