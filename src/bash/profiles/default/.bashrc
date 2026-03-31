#!/bin/bash

# Homebrew (brew)
export PATH="$PATH:/opt/homebrew/bin"

# Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Local overrides (optional)
[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"
