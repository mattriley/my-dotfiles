#!/bin/bash

function node.nodenv.install {

    command -v curl >/dev/null 2>&1 || return 1
    command -v bash >/dev/null 2>&1 || return 1

    curl -fsSL "https://raw.githubusercontent.com/nodenv/nodenv-installer/master/bin/nodenv-installer" | bash

}
