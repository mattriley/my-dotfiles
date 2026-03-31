#!/bin/bash

function util.has_command {

    command -v "$1" >/dev/null 2>&1

}

function util.path_append_once {

    local entry="$1"

    case ":$PATH:" in
        *":$entry:"*) ;;
        *) export PATH="$PATH:$entry" ;;
    esac

}
