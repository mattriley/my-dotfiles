#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f node.require_install_tools >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.nvm.install {

    node.require_install_tools || return 1
    node.setup_nvm_dir

    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh" | bash

}
