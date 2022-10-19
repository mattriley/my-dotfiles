#!/bin/bash
# shellcheck disable=SC1091

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

setup.drawio
setup.nvm
setup.python
