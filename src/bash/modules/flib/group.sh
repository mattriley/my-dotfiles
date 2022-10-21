#!/bin/bash

function flib.group {

    local subject="$1"
    flib group --by "photo.hasSubject.$subject" --schemeName sub --tags "not edit" --yes

}
