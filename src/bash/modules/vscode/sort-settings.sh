#!/bin/bash

function vscode.sort_settings {

    local script_dir="$1"
    local profile="${2:-default}"
    command -v node >/dev/null 2>&1 || return 0

    local profiles_dir="$script_dir/src/bash/profiles"
    [ -d "$profiles_dir" ] || return 0

    dotfiles.collect_profiles "$profiles_dir" "$profile" || return 1

    local profile_dir
    local profile_path
    local settings_path
    for profile_dir in "${DOTFILES_PROFILES[@]}"; do
        profile_path="$profiles_dir/$profile_dir"
        [ -d "$profile_path" ] || continue

        # Escape the space in "Application Support" so pathname expansion works.
        # Enable nullglob so an empty glob doesn't become a literal "*".
        shopt -s nullglob
        for settings_path in "$profile_path"/Library/Application\ Support/Code/*/settings.json; do
            node "$script_dir/src/node/sort-vscode-settings.js" "$settings_path"
        done
        shopt -u nullglob
    done

}
