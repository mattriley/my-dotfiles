#!/bin/bash

function git.push {

    git.commit "$@" && git push

}
