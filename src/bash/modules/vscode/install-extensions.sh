#!/bin/bash

function vscode.install-extensions {

    IFS="|" read -r -a arr <<< "$MY_VSCODE_EXTENSIONS"

    for extension in "${arr[@]}"; do 
        code --install-extension "$extension"
    done

}
