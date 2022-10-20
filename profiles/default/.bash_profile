#!/bin/bash
# shellcheck disable=SC1091

source "$HOME/.bashrc"
source "$HOME/.hostvars"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export CODE_DIR="$HOME/Home/Code"

function display.4k {
    export ITERMOCIL_LAYOUT="even-vertical"
}

function display.default {
    export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"
}

function kill_port { 
    lsof -i TCP:"$1" | grep LISTEN | awk '{print $2}' | xargs kill -9 
}

function commit {
    local default_message="Unspecified changes"
    local message=${1:-$default_message}
    git add -A
    git commit -m"$message" "${@:2}"
}

function push {
    commit "$@" && git push
}

function t {
    npx -p "task-library" task "$@"
}

display.4k

source "$HOME/.bash_profile_extended"






for module_path in "$HOME/bash_modules"/*; do
    for script_path in "$module_path"/*.sh; do
        source "$script_path"
    done
done
