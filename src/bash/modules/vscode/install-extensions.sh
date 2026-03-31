#!/bin/bash

function vscode.install-extensions {
    local extensions="$1"

    [ -n "$extensions" ] || return 0
    util.has_command code || return 1

    IFS="|" read -r -a arr <<< "$extensions"

    for extension in "${arr[@]}"; do
        [ -n "$extension" ] || continue
        code --install-extension "$extension"
    done

}

function vscode.install-extensions.default {
    vscode.install-extensions "${MY_VSCODE_EXTENSIONS:-}"
}
