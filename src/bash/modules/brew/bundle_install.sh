#!/bin/bash

function brew.bundle_install {
    local script_dir="$1"
    command -v brew >/dev/null 2>&1 || return 0
    brew bundle install --file "$script_dir/Brewfile"
}
