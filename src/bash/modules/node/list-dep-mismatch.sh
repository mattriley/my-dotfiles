#!/bin/bash

function node.list_dep_mismatch {

    local package="$1"
    local version="$2"
    local code_dir=${3:-$CODE_DIR}

    find "$code_dir" -type d -name 'node_modules' -prune -o -type f -name 'package.json' -exec node -e "const v = require('{}').dependencies?.['$package']; v && v !== '$version' && console.log('{}')" \;

}
