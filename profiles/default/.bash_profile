#!/bin/bash
# shellcheck disable=SC1091

source "$HOME/.bashrc"
source "$HOME/.hostvars"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export CODE_DIR="$HOME/Home/Code"

function display.4k {
    export ITERMOCIL_LAYOUT="even-vertical"
}

function display.default {
    export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"
}

function kill_port { 
    lsof -i TCP:"$1" | grep LISTEN | awk '{print $2}' | xargs kill -9 
}

function commit {
    local default_message="Unspecified changes"
    local message=${1:-$default_message}
    git add -A
    git commit -m"$message" "${@:2}"
}

function push {
    commit "$@" && git push
}

function t {
    npx -p "task-library" task "$@"
}

display.4k

source "$HOME/.bash_profile_extended"



function extract_node_modules {
    
    local timestamp; timestamp=$(node -p "Date.now()")
    local dest_root="$CODE_DIR/${timestamp}_extracted_node_modules"

    find "$CODE_DIR"/*/node_modules -maxdepth 0 -type d -print0 | 
        while IFS= read -r -d '' source; do 
            local dest="$dest_root${source#"$CODE_DIR"}"
            dest=${dest//\/node_modules/}
            mkdir -p "$dest"
            mv -v "$source" "$dest"
        done

}

function restore_node_modules {
    
    array=()
    while IFS=  read -r REPLY; do
        echo "$REPLY"
        array+=("$REPLY")
    done < <(find "$CODE_DIR"/*_extracted_node_modules -maxdepth 0 -type d)

    # echo "${#array[@]}"

    [[ ${#array[@]} -ne 1 ]] && echo "Absent or ambiguous source directory" && return 1

    # local source_root="${array[0]}"
    local source_root="$array" # first match

    echo "$source_root"

    find "$source_root"/*/node_modules -maxdepth 0 -type d -print0 | 
        while IFS= read -r -d '' source; do 
            local dest="$CODE_DIR${source#"$source_root"}"
            # rm -rf "$dest"
            dest=${dest//\/node_modules/}
            mv -v "$source" "$dest"
        done

}
