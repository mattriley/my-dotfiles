#!/bin/bash

function node.nvm.install {

    node.require_install_tools || return 1
    node.setup_nvm_dir

    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh" | bash

}
