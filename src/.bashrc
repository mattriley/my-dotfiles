# echo "Loading .bashrc"

export AUTHOR_NAME="Matt Riley"
export AUTHOR_EMAIL="m@ttriley.dev"
export AUTHOR_URL="https://github.com/mattriley"
export AUTHOR_GITHUB_USER_NAME="mattriley"

DRAWIO="/Applications/draw.io.app/Contents/MacOS"

export PATH=$DRAWIO:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

