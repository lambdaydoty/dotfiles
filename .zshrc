# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="gallois"
# ZSH_THEME="arrow"
function test_vm() { grep 'hypervisor' /proc/cpuinfo >/dev/null }
function test_deb() { [ -f /etc/issue ] && grep 'Debian' /etc/issue >/dev/null }
case "${OSTYPE}" in
  linux*)   ZSH_THEME="gallois";;
  cygwin*)  ZSH_THEME="arrow";;
  win*)     ;;
  *)        ;;
esac
test_vm  && ZSH_THEME="lambda" # For vm specifically
test_deb && ZSH_THEME="agnoster" # For (GoogleVM) potentia-dev

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  zsh-syntax-highlighting
)
#  zsh-autosuggestions

function source_if_possible()
{
  if [[ -r $1 ]]; then
    source $1
  fi
}
source_if_possible $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

set -o ignoreeof # prevent <c-d> to kill the shell
if [[ -z "$SSH_AUTH_SOCK" ]]; then
  eval `ssh-agent -s` > /dev/null
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## Docker: command-line completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# Multisystem
# unameOut="$(uname -s)"
# case "${unameOut}" in
#   Linux*)   machine=Linux;;
#   Darwin*)  machine=Mac;;
#   CYGWIN*)  machine=Cygwin;;
#   MINGW*)   machine=MinGw;;
#   *)        machine="UNKNOWN:${unameOut}"
# esac
# clipboard_daemon_port=2000
# alias xclip_Linux="nc -N localhost $clipboard_daemon_port"
# alias xclip_Cygwin=putclip
# echo ${machine}
# alias xclip=xclip_$machine

## Aliases
source_if_possible ~/.bash_aliases
source_if_possible ~/.profile
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias ssh="ssh -o ServerAliveInterval=60"
alias jq="jq -C"
# alias docker="sudo docker"
# alias docker-compose="sudo docker-compose"

## Racket lang
source_if_possible /usr/share/racket/pkgs/shell-completion/racket-completion.zsh

