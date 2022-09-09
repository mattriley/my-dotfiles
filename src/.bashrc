#!/bin/bash

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"

export PATH="/Applications/draw.io.app/Contents/MacOS":$PATH

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
