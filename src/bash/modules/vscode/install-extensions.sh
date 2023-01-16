#!/bin/bash

function vscode.install-extensions {

    IFS="|" read -r -a arr <<< "$VSCODE_EXTENSIONS"

    for extension in "${arr[@]}"; do 
        echo $extension
        code --install-extension $extension
    done

}
