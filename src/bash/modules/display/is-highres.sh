#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.has_command >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function display.is-highres {

    util.has_command osascript || return 1

    local bounds
    bounds="$(osascript -e 'tell application "Finder" to get bounds of window of desktop' 2>/dev/null)" || return 1

    IFS=", " read -r -a arr <<< "$bounds"
    local horizontal; horizontal=$(util.trim "${arr[2]}")
    [[ "$horizontal" =~ ^[0-9]+$ ]] || return 1
    [ "$horizontal" -lt "3000" ] && return 1
    return 0

}
