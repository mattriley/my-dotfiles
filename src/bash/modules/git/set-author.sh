#!/bin/bash

function git.set_author {

    command -v git >/dev/null 2>&1 || return 0

    [ -n "${MY_AUTHOR_NAME:-}" ] || return 0
    [ -n "${MY_AUTHOR_EMAIL:-}" ] || return 0

    git config --global user.name "$MY_AUTHOR_NAME" || return 1
    git config --global user.email "$MY_AUTHOR_EMAIL" || return 1

}
