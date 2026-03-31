#!/bin/bash

function python.setup-python {
    if util.has_command pyenv; then
        eval "$(pyenv init -)"
    fi
}
