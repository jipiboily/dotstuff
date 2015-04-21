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
alias zshrc='subl ~/dotstuff/.zshrc'

# BUNDLER AND RAILS
export BUNDLER_EDITOR=subl
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

## Git clean: Delete all local branches that have been merged

# This gitclean is commented as errororing when booting a shell...this is annoying
# alias gitclean="if [ 'master' = `git branch | grep '^* ' | sed -e 's/^[*] //'` ] ; then git branch --merged | grep -v "\*" | xargs git branch -d ; fi"
#
# function gitclean-remote {
#   for x in `git branch -r --merged | grep origin | grep -v '>' | grep -v master  | xargs -L1 | awk '{split($0,a,"/"); print a[2]}'` ; do git push origin :$x ; done
# }

## GitHub for mac
alias gh='github'

# CUSTOM UTILITIES

## METRICS WATCH
alias mw="cd ~/code/metrics-watch"

## Graffweb
alias gw="cd ~/code/graffweb"

## RAINFOREST
. ~/dotstuff/zsh/plugins/autoenv.zsh

alias rf="cd ~/rainforest/rainforest"
alias tala="cd ~/rainforest/tala"
alias spout="cd ~/rainforest/spout"
alias blog="cd ~/rainforest/blog"
alias doc="cd ~/rainforest/docs"
alias z='zeus'
alias zr='z rake'
alias zmig='zr db:migrate --trace && RAILS_ENV=test zr db:migrate'
alias zrback='zr db:rollback --trace && RAILS_ENV=test zr db:rollback'
alias zroutes='zr routes'
alias zz='be zeus start'

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
  gco develop && gco -b "hotfix/$1"
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

# DOCKER
export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375

function dri {
  docker run -i -t $1 /bin/bash
}

export NVM_DIR="/Users/jipiboily/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
