#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f node.setup_nvm_dir >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.nvm.setup {

    node.setup_nvm_dir

    # Only source if the nvm script is present.
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

}
