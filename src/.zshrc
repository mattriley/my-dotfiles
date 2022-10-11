# echo "Loading .zshrc"
source ~/.bash_profile
source ~/hostvars.sh

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  dirhistory
  git
  nvm
  timer
  zsh-autosuggestions
)

# nvm 
# export NVM_LAZY=0
export NVM_AUTOLOAD=1

source $ZSH/oh-my-zsh.sh

# User configuration

export FLIB_CODE_PATH="$HOME/Home/code/flib"

function kill_port() { 
    lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9 
}

function tink() {
    local temp="$HOME/code/temp"
    mkdir -p "$temp"
    cd "$temp"
    code "$(date +"%Y-%m-%dT%H-%M").js" .
}

function photos() {
    cd "$MY_PHOTOS" && use_flib
}

function use_flib() {
    local node_version="$(cat $FLIB_CODE_PATH/.nvmrc)"
    nvm use "$node_version"
}

function flib_groupby() {
    # flib group --by photo.hasSubject.$1 --schemeName sub --yes
    flib group --by photo.hasSubject.$1 --schemeName sub --tags "not edit" --yes
}

function use_streamdestiny() {
    STREAM_DESTINY_DIR_PATH=~/Home/code/streamdestiny
    node_version=`cat $STREAM_DESTINY_DIR_PATH/.nvmrc`    
    nvm use $node_version
    cd $STREAM_DESTINY_DIR_PATH
    export BOOKMARKS_EVENT_DOCUMENT=~/Home/Code/my-data/src/event-data/bookmarks/uncategorised.json
    export BOOKMARKS_COLLECTION_DOCUMENT=~/Home/Code/my-data/dist/collections/bookmarks.json
    export BOOKMARKS_SCRAPER_CACHE=~/Home/Code/my-data/src/app-data/bookmarks-scraper-cache    
}
