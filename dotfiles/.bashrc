#!/bin/bash
# shellcheck disable=SC1091

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export MY_PHOTOS="$HOME/Home/Photos • Matt"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export FLIB_CODE_PATH="$HOME/Home/code/flib"

function display.4k {
    export ITERMOCIL_LAYOUT="even-vertical"
}

function display.default {
    export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"
}

function setup.drawio {
    export PATH="/Applications/draw.io.app/Contents/MacOS":$PATH
}

function setup.nvm {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
}

function setup.python {
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
}

display.4k
setup.drawio
setup.nvm
setup.python

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

function flib.photos {
    local node_version; node_version="$(cat "$FLIB_CODE_PATH/.nvmrc")"
    cd "$MY_PHOTOS" && nvm use "$node_version"
}

function flib.groupby {
    # flib group --by photo.hasSubject.$1 --schemeName sub --yes
    flib group --by "photo.hasSubject.$1" --schemeName sub --tags "not edit" --yes
}
