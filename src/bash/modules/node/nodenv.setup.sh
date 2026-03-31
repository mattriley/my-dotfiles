#!/bin/bash

function node.nodenv.setup {

    # Avoid failing shell startup if nodenv isn't installed.
    util.has_command nodenv || return 0
    eval "$(nodenv init -)"

}
