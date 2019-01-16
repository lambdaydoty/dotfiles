clipboard_daemon_port=2000

# Multisystem
case "${OSTYPE}" in
  linux*)
    case $(cat /etc/issue | head -n1) in
      Debian*)  alias xclip="nc -q0 localhost $clipboard_daemon_port";;
      Ubuntu*)  alias xclip="nc -N localhost $clipboard_daemon_port";;
    esac
    ;;
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
