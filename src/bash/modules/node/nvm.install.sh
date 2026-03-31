#!/bin/bash
# shellcheck disable=SC1091

export NVM_DIR="$HOME/.nvm"

function node.nvm.install {

    command -v curl >/dev/null 2>&1 || return 1
    command -v bash >/dev/null 2>&1 || return 1

    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh" | bash

}
