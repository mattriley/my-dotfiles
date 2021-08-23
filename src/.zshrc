# echo "Loading .zshrc"
source ~/.bash_profile

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
  git
  zsh-nvm
  zsh-autosuggestions
)

# zsh-nvm
export NVM_COMPLETION=true 
export NVM_LAZY_LOAD=true
export NVM_NO_USE=true
export NVM_AUTO_USE=true

source $ZSH/oh-my-zsh.sh

# User configuration

export JAVA_HOME=jdk-install-dir
export PATH=$JAVA_HOME/bin:$PATH

alias reload=". ~/.zshrc"
alias k="kubeCtl"
alias batect="./batect"
alias task="./task"

function brew_install() {
    brew install tree
    brew install ffmpeg
}

function clear_bash_history() {
    history -c
}

function file_count() {
    find . -type f | wc -l
    # excludes symlinks
}

function kill_port() { 
    lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9 
}

function list_all_processes() {
    ps aux
    # a = show processes for all users
    # u = display the process's user/owner
    # x = also show processes not attached to a terminal
}

function filter_processes() {
    ps aux | grep $1
}

function docker_list_all_container_ids() {
    docker ps -aq
}

function docker_stop_all_running_containers() {
    docker stop $(docker ps -aq)
}

function docker_remove_all_containers() {
    docker rm $(docker ps -aq)
}

function docker_remove_all_images() {
    docker rmi $(docker images -q)
}

function docker_bash() {
    docker container run -it $1 bash
}

function commit() {
    default_message="Unspecified changes"
    message=${1:-$default_message}
    git add -A
    git commit -m"$message"
}

function push() {
    commit $@
    git push
}

function use_photos() {
    cd ~"/docs/Matt • Photos"
    use_flib
}

export FLIB_DATA_BASE_PATH="$HOME/code/my-data/src/flib-data"
export FLIB_CODE_PATH="$HOME/code/flib"

function use_flib() {
    #export NODE_OPTIONS="--max_old_space_size=4096" # --inspect"
    node_version=`cat $FLIB_CODE_PATH/.nvmrc`    
    nvm use $node_version   
}

function dev_flib() {
    cd $FLIB_CODE_PATH
    ./task itermocil
}

function flib_missing_faces() {
    flib group --by "photo.facesAssigned" --schemeName "missingFaces"
}

function use_streamdestiny() {
    STREAM_DESTINY_DIR_PATH=~/code/streamdestiny
    node_version=`cat $STREAM_DESTINY_DIR_PATH/.nvmrc`    
    nvm use $node_version
    cd $STREAM_DESTINY_DIR_PATH
    export BOOKMARKS_EVENT_DOCUMENT=~/Code/my-data/src/event-data/bookmarks/uncategorised.json
    export BOOKMARKS_COLLECTION_DOCUMENT=~/Code/my-data/dist/collections/bookmarks.json
    export BOOKMARKS_SCRAPER_CACHE=~/Code/my-data/src/app-data/bookmarks-scraper-cache    
}

