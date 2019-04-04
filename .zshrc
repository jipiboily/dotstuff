# ZSH specific stuff

## HISTORY
. ~/dotstuff/zsh/plugins/history.zsh
. ~/dotstuff/zsh/plugins/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## KEYBOARD NAVIGATION
bindkey "^[[H" beginning-of-line # fn + left
bindkey "^[[F" end-of-line       # fn + right
bindkey '[D' backward-word       # alt + left
bindkey '[C' forward-word        # alt + right

## COMPLETION
autoload -Uz compinit
compinit

## UTILITIES

### Load color helpers
autoload -U colors && colors

## PROMPT
# Source for the VCS stuff: http://stackoverflow.com/a/1128583/398289
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
PROMPT='%{$(pwd|grep --color=always /)%${#PWD}G%} $(vcs_info_wrapper)-> '
# PROMPT='$fg[cyan]%{$(pwd)%${#PWD}G%}$reset_color $(vcs_info_wrapper)-> '
# RPROMPT=$'$(vcs_info_wrapper)'

# RBENV (from Hombrew)
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# PATH
export PATH=/usr/local/bin:$PATH:/usr/local/bin

## Use the binstubs (for Ruby projects) if available
export PATH=./bin:$PATH

## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Source my env vars that I don't want to share
. ~/.env-vars

# SHELL ALIASES
alias ll='ls -al'
alias l='ll'
alias p='ps aux | grep -i '
alias zshrc='atom ~/dotstuff/.zshrc'

# BUNDLER AND RAILS
export BUNDLER_EDITOR=atom
alias be='bundle exec'
alias ber='be rake'
alias mig='be rake db:migrate --trace && RAILS_ENV=test be rake db:migrate'
alias rback='be rake db:rollback --trace && RAILS_ENV=test be rake db:rollback'
alias b='bundle'
alias bi='b install'
alias bu='b update'
alias gg='be guard'

alias pow='powder restart'

# GIT
alias git='hub'
alias gpll='git pull --rebase'
alias gpl=gpll

alias gpff='git pull --ff-only'
alias gpf=gpff
alias gdiffc='git diff --cached'

alias gst='git status'
alias gco='git checkout'
alias g='git'
alias ga='git add -A'
alias gb='git branch'
alias gm='git merge'
alias gca='git commit -a'
alias gcm='git commit -a -m'
alias gp='git push'
alias gcp='git cherry-pick'
alias greset='git reset --hard HEAD'
alias gclean='git add -A && git reset --hard HEAD'
alias gstash='git add -A && git stash'
alias gdf='g diff'

# GIT UTILITIES

## GitHub for mac
alias gh='github'

# CUSTOM UTILITIES

## Shortcut to projets
alias mw="cd ~/code/metrics-watch"
alias mws="cd ~/code/metricswatch.com-2019"
alias mwcom="cd ~/code/metricswatch.com-2018"
alias gw="cd ~/code/graffweb"
alias clms="cd ~/code/clms-pro"


## Git branch helpers
function feature {
  develop_exists=`git show-ref refs/heads/develop`
  if [ -n "$develop_exists" ]; then
    gco develop
  else
  gco master
  fi
  gco -b "feature/$1"
}

function hotfix {
develop_exists=`git show-ref refs/heads/develop`
  if [ -n "$develop_exists" ]; then
    gco develop
  else
  gco master
  fi
  gco -b "hotfix/$1"
}

# KILL ALL THE THINGS!
function massacre {
  # if param is ruby, this is the equivalent
  # ps ax | grep ruby  | awk '{print $1}' | xargs kill -9
  ps ax | grep $1  | awk '{print $1}' | xargs kill -9
}

# SERVE static website
function serve {
  port="${1:-3000}"
  ruby -r webrick -e "s = WEBrick::HTTPServer.new(:Port => $port, :DocumentRoot => Dir.pwd); trap('INT') { s.shutdown }; s.start"
}

# USELESS but fun
alias animal='curl -s http://animals.ivolo.me/\?index\=$1'

# ATOM.IO
## This changes the default path for new packages created via the generator
ATOM_REPOS_HOME=/Users/jipiboily/code

# Go
export GOPATH=$HOME/go
export CDPATH=$CDPATH:$GOROOT/src/pkg:$GOPATH/src/code.google.com/p:$GOPATH/src/github.com:$GOPATH/src/git.tech-angels.net
export PATH=$PATH:$(go env GOPATH)/bin

# DOCKER
# export DOCKER_HOST=tcp://192.168.99.100:2376 DOCKER_CERT_PATH=/Users/jipiboily/.docker/machine/machines/default DOCKER_TLS_VERIFY=1

function dri {
  docker run -i -t $1 /bin/bash
}

export NVM_DIR="/Users/jipiboily/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"

# Charts & Stuff
BROWSER_PATH=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
