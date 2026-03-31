#!/bin/bash

function macos.set_screencapture_location {

    command -v defaults >/dev/null 2>&1 || return 0
    command -v killall >/dev/null 2>&1 || return 0

    if [ -n "${SCREENCAPTURE_DIR:-}" ] && [ -d "$SCREENCAPTURE_DIR" ]; then
        if defaults write com.apple.screencapture location "$SCREENCAPTURE_DIR"; then
            killall SystemUIServer 2>/dev/null || true
            echo "Screenshot location set to $SCREENCAPTURE_DIR"
        else
            echo "Error: failed to set screenshot location via defaults" >&2
            return 1
        fi
    else
        echo "Error: Directory $SCREENCAPTURE_DIR does not exist"
        return 1
    fi

}
