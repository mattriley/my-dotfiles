#!/bin/bash
# shellcheck disable=SC1091

if ! declare -f util.has_command >/dev/null 2>&1; then
    # shellcheck disable=SC1090,SC1091
    source "$(cd "$(dirname "${BASH_SOURCE[0]}")/../util" && pwd)/common.sh"
fi

function python.setup-python {
    if util.has_command pyenv; then
        eval "$(pyenv init -)"
    fi
}
