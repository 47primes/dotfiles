PATH=$PATH:/usr/local/sbin

# Load in the git branch prompt script.
source ~/.git-prompt.sh

export CLICOLOR=1
export TERM="xterm-color"
PS1="\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\] Yes, Master? "

export BUNDLER_EDITOR='vim'
export ARCHFLAGS='-arch x86_64'
export HISTTIMEFORMAT='%F %T '

alias ip='curl http://remote-ip.herokuapp.com'
alias migrate='bundle exec rake db:migrate db:test:prepare'
alias rc='bundle exec rails c'
alias rdb='bundle exec rails dbconsole'

rstart() {
  rstop
  rails s -d
  sidekiq -e development -L log/sidekiq.log -P tmp/pids/sidekiq.pid -d
}

rstop() {
  if [ -f tmp/pids/server.pid ] ; then
    kill -9 `cat tmp/pids/server.pid`
    rm tmp/pids/server.pid
  fi

  if [ -f tmp/pids/sidekiq.pid ] ; then
    kill -9 `cat tmp/pids/sidekiq.pid`
    rm tmp/pids/sidekiq.pid
  fi

  rails runner "Sidekiq::Queue.new.clear"
}

fr() { find . -name ''${3:-*.rb}'' | xargs perl -pi -e 's/'${1}'/'${2}'/g'; }

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
