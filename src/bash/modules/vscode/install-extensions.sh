#!/bin/bash

function vscode.install-extensions {

    [ -n "${MY_VSCODE_EXTENSIONS:-}" ] || return 0
    command -v code >/dev/null 2>&1 || return 1

    IFS="|" read -r -a arr <<< "$MY_VSCODE_EXTENSIONS"

    for extension in "${arr[@]}"; do 
        [ -n "$extension" ] || continue
        code --install-extension "$extension"
    done

}
