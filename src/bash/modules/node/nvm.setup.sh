#!/bin/bash
# shellcheck disable=SC1091

function node.nvm.setup {

    # Default install location, but allow overriding via env var.
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

    # Only source if the nvm script is present.
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

}
