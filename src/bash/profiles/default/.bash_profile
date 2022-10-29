#!/bin/bash
# shellcheck disable=SC1090,SC1091

source "$HOME/.bashrc"
source "$HOME/.hostvars"

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

for module_path in "$BASH_MODULES/"*; do
    for script_path in "$module_path/"*.sh; do
        source "$script_path"
    done
done

function prompt.dev {
    export PS1="\[\033[01;35m\]\u@\h:\[\033[01;34m\]\$(git.parse_git_branch) \[\033[01;32m\]\w \[\033[01;34m\]>\[\e[0m\]"
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
