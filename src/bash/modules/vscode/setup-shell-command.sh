#!/bin/bash

function vscode.setup-shell-command {

    local vscode_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

    case ":$PATH:" in
        *":$vscode_bin:"*) ;;
        *) export PATH="$PATH:$vscode_bin" ;;
    esac

}
