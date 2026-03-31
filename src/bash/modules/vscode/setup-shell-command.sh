#!/bin/bash

function vscode.setup-shell-command {

    local vscode_bin="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    util.path_append_once "$vscode_bin"

}
