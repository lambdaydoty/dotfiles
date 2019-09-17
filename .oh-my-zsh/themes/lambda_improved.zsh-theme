LCHAR_WIDTH=%1G

LCHAR='λ'

PROMPT='%{$fg[yellow]%}%{$LCHAR$LCHAR_WIDTH%} %{$reset_color%}%~/ '
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*"
