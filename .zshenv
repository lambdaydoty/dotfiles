# Multisystem
unameOut="$($(where uname))"
case "${unameOut}" in
  Linux*)   machine=Linux;;
  Darwin*)  machine=Mac;;
  CYGWIN*)  machine=Cygwin;;
  MINGW*)   machine=MinGw;;
  *)        machine="UNKNOWN:${unameOut}"
esac
clipboard_daemon_port=2000
alias _xclip_Linux="nc -N localhost $clipboard_daemon_port"
alias _xclip_Cygwin=putclip
alias xclip=_xclip_$machine
# echo ${machine}
