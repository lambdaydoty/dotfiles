clipboard_daemon_port=2000

# Multisystem
case "${OSTYPE}" in
  linux*)   alias xclip="nc -N localhost $clipboard_daemon_port";;
  cygwin*)  alias xclip=putclip;;
  win*)     ;;
  *)        ;;
esac

alias art=artisan
alias phpunit='vendor/bin/phpunit'
function artisan() {
    php artisan "$@"
}

alias truffle=./node_modules/.bin/truffle
alias hke='cd /home/vagrant/code/hke/backend'
alias demo='cd /home/vagrant/code/demo'
