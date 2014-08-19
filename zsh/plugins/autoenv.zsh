# When the current working directory changes, run a method that checks for a
# .env file, then sources it. Happy days.
autoload -U add-zsh-hook
load-local-conf() {
  # check file exists, is regular file and is readable:
  if [[ -f .env && -r .env ]]; then
    #source .env
    # my .env files are usually like FOO=bar instead of scripts to be executed
    # so export all the vars, ignoring comments
    export $(sed '/^#/d' .env)
  fi
}
add-zsh-hook chpwd load-local-conf