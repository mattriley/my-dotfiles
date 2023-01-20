#!/bin/bash

function prompt.git_branch {
    local branch; branch="$(git.parse_git_branch)"
    [ "$branch" ] && echo " $branch"
}

function prompt.dev {
    export PS1=${1:-$DEV_PROMPT}
}
