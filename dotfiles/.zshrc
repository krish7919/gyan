# Following commands are required for autocomplete to work.
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Setup prezto: 
# git clone --recursive https://github.com/krish7919/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# cd ~/.zprezto && git checkout krish-customisations
# setopt EXTENDED_GLOB
# for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#   ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
# done
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# PATH customisations based on the tools installed
export PATH="/usr/local/opt/binutils/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/m4/bin:$PATH"
export PATH="/usr/local/opt/unzip/bin:$PATH"
export PATH="/usr/local/opt/mysql-client@5.7/bin:$PATH"
export PATH="/usr/local/opt/curl-openssl/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# Set my local bin dir
mkdir -p $HOME/bin
export PATH="$HOME/bin:$PATH"

# Autocomplete hostnames from ./ssh/config
# zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# My aliases
alias vim='nvim'
alias v='nvim'
alias ls='ls -G' # for colors
alias ll='ls -GFlrtha'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto' 
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias showhiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehiddenfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias gd="git diff" 
alias gdstaged="git diff --cached"
alias gt="git tag --sort=-creatordate | head"
# alias gd='git difftool --no-symlinks --dir-diff'
alias ga='git add'    
alias ga="git add"    
alias gstat="git status"
alias gl="git log -2"   
alias gb="git branch"   
alias gp="git pull"
# alias zookeeper='cd $KAFKA_HOME; ./bin/zookeeper-server-start.sh ./config/zookeeper.properties'
# alias kafka-server='cd $KAFKA_HOME; ./bin/kafka-server-start.sh ./config/server.properties'    
# alias kafka-topic='cd $KAFKA_HOME; ./bin/kafka-topics.sh --create --topic krishTopic --zookeeper localhost:2181 --partitions 1 --replication-factor 1'
# alias kafka-console-producer='cd $KAFKA_HOME; ./bin/kafka-console-producer.sh  --topic krishTopic --broker-list localhost:9092'
# alias kafka-console-consumer='cd $KAFKA_HOME; ./bin/kafka-console-consumer.sh  --topic krishTopic --zookeeper localhost:2181'  
# alias storm-nimbus='cd $STORM_HOME; ./bin/storm nimbus'                                                                        
# alias storm-supervisor='cd $STORM_HOME; ./bin/storm supervisor'
# alias storm-ui='cd $STORM_HOME; ./bin/storm ui'
alias envpy3='. ~/Desktop/workspace/venv3/bin/activate'
#alias awsecrlogin='$(aws ecr get-login-password)'
alias watch='watch --color'
# Editor settings
EDITOR=nvim
alias v='nvim'
alias vim='nvim'

# Kitty autocompletion
kitty + complete setup zsh | source /dev/stdin
# Kitty diff - so pretty!
alias kd='kitty +kitten diff'
alias diff='kitty +kitten diff'


# Add my SSH keys to the keychain
# Needed for mac as the key is not auto-added to the keychain at login
#/usr/bin/ssh-add -K ~/.ssh/gitlab-ldap 
#/usr/bin/ssh-add -K ~/.ssh/id_rsa
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_ed25519
#zstyle ':prezto:module:ssh:load' identities 'id_rsa' 'gitlab-ldap'


# Scala & Spark
export SCALA_HOME=/usr/local/opt/scala@2.11
export PATH=$PATH:$SCALA_HOME/bin
export SPARK_HOME=/Users/kriiyer/bin/spark-2.4.0-bin-hadoop2.7
export PATH=$PATH:$SPARK_HOME/bin
# the following causes `pyspark` to open a jupyter notebook
export PYSPARK_DRIVER_PYTHON=/Users/kriiyer/Desktop/workspace/venv3.7/bin/python3
export PYSPARK_PYTHON=/Users/kriiyer/Desktop/workspace/venv3.7/bin/python3
export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/build:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip
# Hadoop
export PATH=$PATH:/Users/kriiyer/bin/hadoop-2.8.3/bin

# AWS CLI settings - pip3 install awscli --upgrade --user
export PATH=$PATH:~/Library/Python/3.7/bin

################### to be tested ##################
# set title in Kitty tabs
#function set-title-precmd() {
#  printf "\e]2;%s\a" "${PWD/#$HOME/~}"
#}
#
#function set-title-preexec() {
#  printf "\e]2;%s\a" "$1"
#}
#
#autoload -Uz add-zsh-hook
#add-zsh-hook precmd set-title-precmd
#add-zsh-hook preexec set-title-preexec
##################################################

complete -C '/opt/homebrew/bin/aws_completer' aws

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function ssh() {
    kitty +kitten ssh "$@"
}

# Java exports
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH=$JAVA_HOME:$PATH
export MAVEN_OPTS="-Xmx1024m -XX:MaxMetaspaceSize=512m"

complete -o nospace -C $HOME/bin/terraform.0.12.20 terraform.0.12.20

function sed_custom_search_replace_text_on_macos(){
    file_extension="${1}"
    original_string="${2}"
    new_string="${3}"

    LC_ALL=C find . -type f -name "*.${file_extension}" -exec sed -i '' s/${original_string}/${new_string}/ {} +
}

export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain
export PATH=/opt/homebrew/bin:$PATH


# source /usr/local/bin/source-aliases TODO add custom aliases in this file.
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(rbenv init -)"

# Kubectl autocompletion
source <(kubectl completion zsh)

# Java runtime
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

function codeline(){
    file_name="${1}"
    line_number="${2}"
    code -g ${file_name}:${line_number}
}
alias cl='codeline'

function gen_strong_password(){
    cat /dev/urandom | LC_ALL=C tr -dc "[[:graph:]]" |head -c28;echo
}

# ASDF Setup
. $(brew --prefix asdf)/libexec/asdf.sh
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
## append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
## initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
## Set GOROOT dynamically
. ${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/golang/set-env.zsh
## golangci-lint autocompletion
source <(golangci-lint completion zsh)

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Golang settings - use asdf to manage Go installations!
export GO111MODULE=auto
#export GOROOT="$(asdf where golang)/go/"
export GOCACHE=$HOME/bin/gocache
export GOBIN=$HOME/bin/go-bin
export PATH=$GOBIN:$PATH
export GOPATH=$HOME/Desktop/workspace/
export GOPRIVATE="git.curve.tools,go.curve.tools"
alias godoc-local='echo "Listening on localhost:6789" && godoc -http localhost:6789'

# Rust runtime
export CARGO_HOME=~/bin/cargo
export RUSTUP_HOME=~/bin/rustup
export PATH="$HOME/bin/cargo/bin:$PATH"
alias rustdoc='rustup doc'

export PATH="$PATH:$HOME/.rd/bin"

# Podman settings
export DOCKER_HOST="unix://${HOME}/.local/share/containers/podman/machine/podman.sock"


# This should be at the end of the file
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
