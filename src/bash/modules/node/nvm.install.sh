#!/bin/bash
# shellcheck disable=SC1091

export NVM_DIR="$HOME/.nvm"

function node.nvm.install {

    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh" | bash

}
