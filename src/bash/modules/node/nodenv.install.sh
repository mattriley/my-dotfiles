#!/bin/bash

function node.nodenv.install {

    node.require_install_tools || return 1

    curl -fsSL "https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer" | bash

}
