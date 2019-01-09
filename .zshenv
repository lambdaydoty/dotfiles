# Multisystem
unameOut="$(/usr/bin/uname -s)"
case "${unameOut}" in
  Linux*)   machine=Linux;;
  Darwin*)  machine=Mac;;
  CYGWIN*)  machine=Cygwin;;
  MINGW*)   machine=MinGw;;
  *)        machine="UNKNOWN:${unameOut}"
esac
clipboard_daemon_port=2000
alias xclip_Linux="nc -N localhost $clipboard_daemon_port"
alias xclip_Cygwin=putclip
alias xclip=xclip_$machine
# echo ${machine}
