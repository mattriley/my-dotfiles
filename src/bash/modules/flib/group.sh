#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.has_command >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function flib.group {

    local subject="$1"
    [ -n "$subject" ] || return 1
    util.has_command flib || return 1

    flib group --by "photo.hasSubject.$subject" --schemeName sub --tags "not edit" --yes

}
