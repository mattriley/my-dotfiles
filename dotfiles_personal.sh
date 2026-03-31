#!/bin/bash

export HOME_DIR="$HOME/Home"
export TEMP_DIR="$HOME_DIR/.temp"
export CODE_DIR="${CODE_DIR:-$HOME/Home/Code}"

export ITERMOCIL_LAYOUT_DEFAULT="main-vertical"
export ITERMOCIL_LAYOUT_HIGHRES="even-vertical"
export ITERMOCIL_LAYOUT="${ITERMOCIL_LAYOUT:-$ITERMOCIL_LAYOUT_DEFAULT}"

# WARNING: Naming this VSCODE_EXTENSIONS will conflict and cause side effects with VSCode.
export MY_VSCODE_EXTENSIONS="bierner.markdown-mermaid | dbaeumer.vscode-eslint | dnicolson.binary-plist | marp-team.marp-vscode | timonwong.shellcheck | vscode-icons-team.vscode-icons"

export MY_AUTHOR_NAME="Matt Riley"
export MY_AUTHOR_EMAIL="m@ttriley.dev"
export MY_AUTHOR_URL="https://github.com/mattriley"
export MY_PHOTOS="$HOME_DIR/Photos › Matt"
export PHOTOS_PARTIAL_PATH="$HOME_DIR/Photos › "
export PHOTOS_DEFAULT_PROFILE="Matt"
export SCREENCAPTURE_DIR="$HOME_DIR/Screenshots"
