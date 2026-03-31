#!/bin/bash

function git.set_author {
    local author_name="$1"
    local author_email="$2"

    command -v git >/dev/null 2>&1 || return 0

    [ -n "$author_name" ] || return 0
    [ -n "$author_email" ] || return 0

    git config --global user.name "$author_name" || return 1
    git config --global user.email "$author_email" || return 1

}
