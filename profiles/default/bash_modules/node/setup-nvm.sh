#!/bin/bash
# shellcheck disable=SC1091

function node.setup_nvm {

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

}
