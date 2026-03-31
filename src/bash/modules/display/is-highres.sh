#!/bin/bash

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
