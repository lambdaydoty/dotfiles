#
# .zshenv will be sourced by vim env
#

alias jsgrep='grep -r --include=\*.{js,json} --exclude-dir={node_modules,build,doc}'

clip_port1=3000
clip_port2=4000

# Multisystem
case "${OSTYPE}" in
  linux*)   alias alias xclip="tee >(nc -N localhost ${clip_port1}) >(nc -N localhost ${clip_port2}) > /dev/null";;
  cygwin*)  alias xclip=putclip;;
  win*)     ;;
  *)        ;;
esac

# WSL
#if [[ $(cat /proc/version) == *"Microsoft"* ]]; then
#  alias xclip="/mnt/c/Windows/System32/clip.exe"
#fi

if [ -f /etc/issue ]; then
  case $(cat /etc/issue | head -n1) in
    Debian*)  ;;
    Ubuntu*)  ;;
    *)        ;;
  esac
fi
