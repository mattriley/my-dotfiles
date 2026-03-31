#!/bin/bash

function node.nodenv.setup {

    # Avoid failing shell startup if nodenv isn't installed.
    command -v nodenv >/dev/null 2>&1 || return 0
    eval "$(nodenv init -)"

}
