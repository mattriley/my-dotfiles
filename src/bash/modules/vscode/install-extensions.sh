#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.has_command >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function vscode.install-extensions {

    [ -n "${MY_VSCODE_EXTENSIONS:-}" ] || return 0
    util.has_command code || return 1

    IFS="|" read -r -a arr <<< "$MY_VSCODE_EXTENSIONS"

    for extension in "${arr[@]}"; do 
        [ -n "$extension" ] || continue
        code --install-extension "$extension"
    done

}
