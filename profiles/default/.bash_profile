#!/bin/bash
# shellcheck disable=SC1090,SC1091

source "$HOME/.bashrc"
source "$HOME/.hostvars"

export BASH_SILENCE_DEPRECATION_WARNING=1

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export CODE_DIR="$HOME/Home/Code"

for module_path in "$HOME/bash_modules"/*; do
    for script_path in "$module_path"/*.sh; do
        source "$script_path"
    done
done

function display.4k {
    export ITERMOCIL_LAYOUT="even-vertical"
}

function display.default {
    export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"
}

function t {
    npx -p "task-library" task "$@"
}

node.setup_nvm
display.4k
source "$HOME/.bash_profile_extended"
