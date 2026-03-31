#!/bin/bash

function node.nvm.setup {

    node.setup_nvm_dir

    # Only source if the nvm script is present.
    # shellcheck disable=SC1091
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

}
