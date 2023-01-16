#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

source "$HOME/.bashrc"

export HOSTVARS="$HOME/.hostvars"
touch "$HOSTVARS" && source "$HOSTVARS"

export PATH=/opt/homebrew/bin:$PATH
export BASH_SILENCE_DEPRECATION_WARNING=1

export HOME_DIR="$HOME/Home"
export TEMP_DIR="$HOME_DIR/.temp"
export CODE_DIR="$HOME_DIR/Code"
export BASH_MODULES="$CODE_DIR/my-dotfiles/src/bash/modules"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export MY_PHOTOS="$HOME_DIR/Photos • Matt"

export NORM=$(tput sgr0)
export BOLD=$(tput bold)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)

for module_path in "$BASH_MODULES/"*; do
    for script_path in "$module_path/"*.sh; do
        source "$script_path"
    done
done

function prompt.git_branch {
    local branch="$(git.parse_git_branch)"
    [ "$branch" ] && echo " $branch"
}

function prompt.dev {
    export PS1="\[${BOLD}${GREEN}\]\w\[${NORM}${BOLD}${BLUE}\]\$(prompt.git_branch)\[${NORM} ${BOLD}\]$\[${NORM}\]"
}

function display.4k {
    export ITERMOCIL_LAYOUT="even-vertical"
}

function display.default {
    export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"
}

function t {
    npx -p "task-library" task "$@"
}

prompt.dev
display.4k
node.setup_nvm
