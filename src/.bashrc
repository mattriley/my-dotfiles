# echo "Loading .bashrc"

DRAWIO="/Applications/draw.io.app/Contents/MacOS"

export PATH=$DRAWIO:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
