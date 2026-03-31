#!/bin/bash

function git.parse_git_branch {

    local branch

    branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" || return 0
    printf '(%s)\n' "$branch"

}
