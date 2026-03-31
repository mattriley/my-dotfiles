#!/bin/bash

function gcm {
    if git diff --staged --quiet; then
        echo 'No staged changes.'
        return 1
    fi

    local msg_file
    msg_file="$(mktemp)"

    {
        cat <<'EOF'
Write a git commit message for the staged diff below.

Rules:
- Return ONLY the commit message text
- Use Conventional Commits
- Keep the first line <= 72 characters
- Add a body only if it materially helps
- Be specific about what changed

EOF
        git diff --staged --unified=3
    } | codex exec --skip-git-repo-check > "$msg_file"

    if [ ! -s "$msg_file" ]; then
        echo 'Failed to generate a commit message.'
        rm -f "$msg_file"
        return 1
    fi

    echo
    echo '--- Suggested commit message ---'
    cat "$msg_file"
    echo '--------------------------------'
    echo

    printf 'Use this message? [y/e/N] '
    read -r choice

    case "$choice" in
        y|Y)
            git commit -F "$msg_file"
            ;;
        e|E)
            "${EDITOR:-vi}" "$msg_file"
            git commit -F "$msg_file"
            ;;
        *)
            echo 'Aborted.'
            rm -f "$msg_file"
            return 1
            ;;
    esac

    rm -f "$msg_file"
}
