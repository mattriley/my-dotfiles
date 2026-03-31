#!/bin/bash

function prompt.git_branch {
    local branch; branch="$(git.parse_git_branch)"
    [ "$branch" ] && echo " $branch"
}

function prompt.dev_default {
    if [ -n "${ZSH_VERSION:-}" ]; then
        # shellcheck disable=SC2016
        printf '%s\n' '%~$(prompt.git_branch) $ '
        return 0
    fi

    if [ -n "${DEV_PROMPT:-}" ]; then
        printf '%s\n' "$DEV_PROMPT"
        return 0
    fi

    # shellcheck disable=SC2016
    printf '%s\n' '\w$(prompt.git_branch) $ '
}

function prompt.dev {
    export PS1="${1:-$(prompt.dev_default)}"
}
