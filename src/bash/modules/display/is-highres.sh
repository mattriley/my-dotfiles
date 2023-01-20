#!/bin/bash

function display.is-highres {

    IFS=", " read -r -a arr <<< "$(osascript -e 'tell application "Finder" to get bounds of window of desktop')"
    local horizontal; horizontal=$(util.trim "${arr[2]}")
    [ "$horizontal" -lt "3000" ] && return 1
    return 0

}
