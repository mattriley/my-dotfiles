#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.path_append_once >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function vscode.setup-shell-command {

    local vscode_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    util.path_append_once "$vscode_bin"

}
