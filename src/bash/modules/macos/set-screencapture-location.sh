#!/bin/bash

function macos.set_screencapture_location {
    local screencapture_dir="$1"

    command -v defaults >/dev/null 2>&1 || return 0
    command -v killall >/dev/null 2>&1 || return 0

    if [ -n "$screencapture_dir" ] && [ -d "$screencapture_dir" ]; then
        if defaults write com.apple.screencapture location "$screencapture_dir"; then
            killall SystemUIServer 2>/dev/null || true
            echo "Screenshot location set to $screencapture_dir"
        else
            echo "Error: failed to set screenshot location via defaults" >&2
            return 1
        fi
    else
        echo "Error: Directory $screencapture_dir does not exist"
        return 1
    fi

}
