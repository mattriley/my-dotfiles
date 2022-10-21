#!/bin/bash

function git.commit {

    local message=${1:-"Unspecified changes"}
    git add -A
    git commit -m"$message" "${@:2}"

}
