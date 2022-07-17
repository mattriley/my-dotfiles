# echo "Loading .bashrc"

export DEFAULT_AUTHOR_NAME="Matt Riley"
export DEFAULT_AUTHOR_EMAIL="m@ttriley.dev"
export DEFAULT_AUTHOR_URL="https://github.com/mattriley"

DRAWIO="/Applications/draw.io.app/Contents/MacOS"

export PATH=$DRAWIO:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

