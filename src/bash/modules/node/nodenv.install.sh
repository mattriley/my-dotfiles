#!/bin/bash

if ! declare -f node.require_install_tools >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"
fi

function node.nodenv.install {

    node.require_install_tools || return 1

    curl -fsSL "https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer" | bash

}
