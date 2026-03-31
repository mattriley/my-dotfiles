#!/bin/bash
# shellcheck disable=SC2034

function node.collect_project_node_modules {

    local code_dir="$1"

    NODE_MODULE_PATHS=()

    shopt -s nullglob
    NODE_MODULE_PATHS=("$code_dir"/*/node_modules)
    shopt -u nullglob

}

function node.collect_extracted_node_modules_roots {

    local temp_dir="$1"

    NODE_EXTRACTED_ROOTS=()

    shopt -s nullglob
    NODE_EXTRACTED_ROOTS=("$temp_dir"/*_extracted_node_modules)
    shopt -u nullglob

}

function node.require_install_tools {

    command -v curl >/dev/null 2>&1 || return 1
    command -v bash >/dev/null 2>&1 || return 1

}

function node.setup_nvm_dir {

    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

}
