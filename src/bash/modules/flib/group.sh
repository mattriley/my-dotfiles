#!/bin/bash

function flib.group {

    local subject="$1"
    [ -n "$subject" ] || return 1
    command -v flib >/dev/null 2>&1 || return 1

    flib group --by "photo.hasSubject.$subject" --schemeName sub --tags "not edit" --yes

}
