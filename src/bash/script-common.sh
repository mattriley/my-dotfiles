#!/bin/bash
# shellcheck disable=SC2034

dotfiles.setup_styles() {
    if [ -n "${TERM:-}" ] && command -v tput >/dev/null 2>&1; then
        NORM=$(tput sgr0)
        BOLD=$(tput bold)
    else
        NORM=""
        BOLD=""
    fi
}

dotfiles.parse_profile_args() {
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
                exit 0
                ;;
            *)
                PROFILE="$1"
                shift
                ;;
        esac
    done
}

dotfiles.collect_profiles() {
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
