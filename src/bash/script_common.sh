#!/bin/bash
# shellcheck disable=SC2034

function dotfiles.setup_styles {
    if [ -n "${TERM:-}" ] && command -v tput >/dev/null 2>&1; then
        NORM=$(tput sgr0)
        BOLD=$(tput bold)
    else
        NORM=""
        BOLD=""
    fi
}

function dotfiles.parse_profile_args {
    local usage="$1"
    local supports_list="$2"
    shift 2

    DRY_RUN=0
    LIST_ONLY=0
    PROFILE="default"

    while [ $# -gt 0 ]; do
        case "$1" in
            --dry-run)
                DRY_RUN=1
                shift
                ;;
            --list|--plan)
                if [ "$supports_list" -eq 1 ]; then
                    DRY_RUN=1
                    LIST_ONLY=1
                    shift
                else
                    echo "Error: unsupported option: $1" >&2
                    echo "$usage" >&2
                    return 1
                fi
                ;;
            --profile=*)
                PROFILE="${1#*=}"
                shift
                ;;
            --profile)
                PROFILE="${2:-default}"
                shift 2
                ;;
            -h|--help)
                echo "$usage"
                return 2
                ;;
            *)
                PROFILE="$1"
                shift
                ;;
        esac
    done
}

function dotfiles.collect_profiles {
    local profiles_dir="$1"
    local profile="${2:-default}"
    local profile_dir

    DOTFILES_PROFILES=()

    if [ "$profile" = "all" ] || [ -z "$profile" ]; then
        shopt -s nullglob
        for profile_dir in "$profiles_dir"/*; do
            [ -d "$profile_dir" ] || continue
            DOTFILES_PROFILES+=("$(basename "$profile_dir")")
        done
        shopt -u nullglob
    else
        DOTFILES_PROFILES=("$profile")
    fi

    [ "${#DOTFILES_PROFILES[@]}" -gt 0 ] || {
        echo "Error: no profiles found in $profiles_dir" >&2
        return 1
    }
}

function dotfiles.sync_profile_files {
    local script_dir="$1"
    local profile="$2"
    local action_label="$3"
    local handler="$4"
    local target="$script_dir/profiles/$profile"
    local failures=0
    local processed=0
    local path
    local dest
    local base

    if [ ! -d "$target" ]; then
        echo "Error: profile directory not found: $target" >&2
        return 1
    fi

    echo "$action_label $BOLD$profile$NORM profile..."
    echo

    while IFS= read -r -d '' path; do
        dest="$HOME${path#"$target"}"
        base="$(basename "$path")"
        DOTFILES_ITERATE_COUNTED=0

        if ! "$handler" "$path" "$dest" "$base"; then
            failures=$((failures+1))
        fi

        if [ "${DOTFILES_ITERATE_COUNTED:-0}" -eq 1 ]; then
            processed=$((processed+1))
        fi
    done < <(find "$target" -type f -print0)

    if [ "$DRY_RUN" -eq 1 ]; then
        echo
        echo "Plan complete: would process $processed file(s)."
        return 0
    fi

    if [ "$failures" -gt 0 ]; then
        echo "Completed with $failures error(s)." >&2
        return 1
    fi

    echo
}
