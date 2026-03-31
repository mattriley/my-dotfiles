#!/bin/bash

function net.kill_port {

    local port="$1"
    local pids=()

    while IFS= read -r pid; do
        [ -n "$pid" ] && pids+=("$pid")
    done < <(lsof -tiTCP:"$port" -sTCP:LISTEN)

    [ "${#pids[@]}" -gt 0 ] || return 0

    kill "${pids[@]}"

}
