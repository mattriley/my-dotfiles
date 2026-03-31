#!/bin/bash

function python.setup_python {
    if util.has_command pyenv; then
        eval "$(pyenv init -)"
    fi
}
