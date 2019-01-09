clipboard_daemon_port=2000

# Multisystem
case "${OSTYPE}" in
  linux*)   alias xclip="nc -N localhost $clipboard_daemon_port";;
  cygwin*)  alias xclip=putclip;;
  win*)     ;;
  *)        ;;
esac
