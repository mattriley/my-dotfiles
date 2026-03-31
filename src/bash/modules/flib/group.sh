#!/bin/bash

function flib.group {

    local subject="$1"
    [ -n "$subject" ] || return 1
    util.has_command flib || return 1

    flib group --by "photo.hasSubject.$subject" --schemeName sub --tags "not edit" --yes

}
