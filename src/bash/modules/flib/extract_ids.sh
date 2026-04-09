#!/usr/bin/env bash

flib.extract_ids() {

    [ "$#" -eq 0 ] && set -- ./*

    for f in "$@"
    do
        [ -f "$f" ] || continue

        dir="$(dirname "$f")"
        file="$(basename "$f")"

        if [[ "$file" =~ id=([^\.]+) ]]; then
            id="${BASH_REMATCH[1]}"
            ext="${file##*.}"

            new="$dir/$id.$ext"

            if [ ! -e "$new" ]; then
                mv "$f" "$new"
            else
                echo "Skipping (exists): $new"
            fi
        else
            echo "No id found: $file"
        fi
    done
}
