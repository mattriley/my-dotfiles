#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.has_command >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function node.nodenv.setup {

    # Avoid failing shell startup if nodenv isn't installed.
    util.has_command nodenv || return 0
    eval "$(nodenv init -)"

}
