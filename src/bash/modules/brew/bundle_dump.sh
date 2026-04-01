#!/bin/bash

function brew.bundle_dump {
    local script_dir="$1"
    local profile="${2:-default}"
    command -v brew >/dev/null 2>&1 || return 0
    brew bundle dump --file "$script_dir/profiles/$profile/Brewfile" --force
}
