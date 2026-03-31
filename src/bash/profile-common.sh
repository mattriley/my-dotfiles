#!/bin/bash

dotfiles.is_interactive() {
    case $- in
        *i*) return 0 ;;
        *) return 1 ;;
    esac
}

dotfiles.has_function() {
    local fn="$1"

    if [ -n "${ZSH_VERSION:-}" ]; then
        whence "$fn" >/dev/null 2>&1
    else
        declare -f "$fn" >/dev/null 2>&1
    fi
}

dotfiles.load_modules() {
    [ -d "${BASH_MODULES:-}" ] || return 0

    if [ -n "${ZSH_VERSION:-}" ]; then
        setopt local_options null_glob
        local script_path
        for script_path in "$BASH_MODULES"/*/*.sh; do
            # shellcheck disable=SC1090
            source "$script_path"
        done
        return 0
    fi

    shopt -s nullglob
    local module_path
    local script_path
    for module_path in "$BASH_MODULES/"*; do
        for script_path in "$module_path/"*.sh; do
            # shellcheck disable=SC1090
            source "$script_path"
        done
    done
    shopt -u nullglob
}

dotfiles.setup_node() {
    dotfiles.has_function "node.nvm.setup" && node.nvm.setup
    dotfiles.has_function "node.nodenv.setup" && node.nodenv.setup
}

dotfiles.apply_prompt() {
    local is_interactive="$1"
    [ "$is_interactive" -eq 1 ] || return 0
    dotfiles.has_function "prompt.dev" && prompt.dev
}

dotfiles.print_shell_banner() {
    local is_interactive="$1"
    local shell_name="$2"
    [ "$is_interactive" -eq 1 ] && echo "Shell: $shell_name"
}
