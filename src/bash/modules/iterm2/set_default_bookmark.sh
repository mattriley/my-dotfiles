#!/bin/bash

function iterm2.set_default_bookmark {
    local bookmark_guid="$1"

    command -v defaults >/dev/null 2>&1 || return 0
    [ -n "$bookmark_guid" ] || return 0

    if defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$bookmark_guid"; then
        echo "iTerm2 default bookmark set to $bookmark_guid"
    else
        echo "Error: failed to set iTerm2 default bookmark" >&2
        return 1
    fi
}

function iterm2.set_default_bookmark.default {
    iterm2.set_default_bookmark "${ITERM2_DEFAULT_BOOKMARK_GUID:-}"
}
