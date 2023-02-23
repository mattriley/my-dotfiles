#!/bin/bash
# shellcheck disable=SC1090,SC1091,SC2155

source "$HOME/.bashrc"

export HOSTVARS="$HOME/.hostvars"
touch "$HOSTVARS" && source "$HOSTVARS"

export PATH=/opt/homebrew/bin:$PATH
export BASH_SILENCE_DEPRECATION_WARNING=1

export HOME_DIR="$HOME/Home"
export TEMP_DIR="$HOME_DIR/.temp"
export CODE_DIR="$HOME_DIR/Code"
export BASH_MODULES="$CODE_DIR/my-dotfiles/src/bash/modules"
export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export ITERMOCIL_LAYOUT_HIGHRES="even-vertical"
export ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_DEFAULT"

# this was the problem...
export _VSCODE_EXTENSIONS="bierner.markdown-mermaid | dbaeumer.vscode-eslint | dnicolson.binary-plist | marp-team.marp-vscode | timonwong.shellcheck | vscode-icons-team.vscode-icons"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export MY_PHOTOS="$HOME_DIR/Photos • Matt"
export PHOTOS_PARTIAL_PATH="$HOME_DIR/Photos • "
export PHOTOS_DEFAULT_PROFILE="Matt"

export NORM=$(tput sgr0)
export BOLD=$(tput bold)
export RED=$(tput setaf 1)
export GREEN=$(tput setaf 2)
export YELLOW=$(tput setaf 3)
export BLUE=$(tput setaf 4)
export MAGENTA=$(tput setaf 5)

export DEV_PROMPT="\[${BOLD}${GREEN}\]\w\[${NORM}${BOLD}${BLUE}\]\$(prompt.git_branch)\[${NORM} ${BOLD}\]$\[${NORM}\]"

for module_path in "$BASH_MODULES/"*; do
    for script_path in "$module_path/"*.sh; do
        source "$script_path"
    done
done

function t { npx -p "task-library" task "$@"; }
display.is-highres && ITERMOCIL_LAYOUT="$ITERMOCIL_LAYOUT_HIGHRES"
prompt.dev
node.nvm.setup
node.nodenv.setup
