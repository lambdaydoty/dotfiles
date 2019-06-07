#
# .zshenv will be sourced by vim env
#

clipboard_daemon_port=2000

alias jsgrep='grep -r --include=\*.{js,json} --exclude-dir=node_modules'

# Multisystem
case "${OSTYPE}" in
  linux*)   alias xclip="nc -N localhost $clipboard_daemon_port";;
  cygwin*)  alias xclip=putclip;;
  win*)     ;;
  *)        ;;
esac

if [ -f /etc/issue ]; then
  case $(cat /etc/issue | head -n1) in
    Debian*)  ;;
    Ubuntu*)  ;;
    *)        ;;
  esac
fi

# TODO: Deprecated
# alias art=artisan
# alias phpunit='vendor/bin/phpunit'
# function artisan() {
#     php artisan "$@"
# }
# alias truffle=./node_modules/.bin/truffle
# alias hke='cd /home/vagrant/code/hke/backend'
# alias demo='cd /home/vagrant/code/demo'
