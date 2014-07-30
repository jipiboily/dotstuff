# bindkey -e
# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/jipiboily/.zshrc'


# ZSH specific stuff

## HISTORY
. ~/dotstuff/zsh/plugins/history.zsh
. ~/dotstuff/zsh/plugins/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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
eval "$(rbenv init -)"
export RBENV_ROOT=/usr/local/opt/rbenv

# Source my env vars that I don't want to share
. ~/.env-vars

# SHELL ALIASES
alias ll='ls -al'

# BUNDLER AND RAILS
alias be='bundle exec'
alias ber='bundle exec rake'
alias dbmig='bundle exec rake db:migrate --trace && RAILS_ENV=test bundle exec rake db:migrate'
alias dbrollback='bundle exec rake db:rollback --trace && RAILS_ENV=test bundle exec rake db:rollback'
alias b='bundle'
alias bi='bundle install'
alias bu='bundle update'

# GIT
alias gpll='git pull --rebase'
alias gpl=gpll

alias gpff='git pull --ff-only'
alias gpf=gpff
alias gdiffc='git diff --cached'

alias gst='git status'
alias gco='git checkout'
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gm='git merge'
alias gca='git commit -a'
alias gp='git push'
alias greset='git reset --hard HEAD'
alias gclean='git add -A && git reset --hard HEAD'
alias gstash='git add -A && git stash'

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

## RAINFOREST
# alias rf="cd ~/rainforest/rainforest && export $(sed '/^#/d' .env)"
alias zmig='zeus rake db:migrate --trace && RAILS_ENV=test zeus rake db:migrate'
alias zrback='zeus rake db:rollback --trace && RAILS_ENV=test zeus rake db:rollback'

function feature {
  gco develop && gco -b "feature/$1"
}

function feature {
  gco develop && gco -b "hotfix/$1"
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
