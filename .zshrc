export DISPLAY=:0.0
export CLICOLOR=1

eval "$(pyenv init -)"

# aliases
alias psx="ps auxw | grep $1"
alias gst='git status '

# define colors
LBLUE='\[\e[0;36m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
GREEN='\[\e[0;32m\]'
ORANGE='\[\e[0;33m\]'
YELLOW='\e[0;37m\]'
PINK='\[\e[0;91m\]'
BLACK="\[\e[0;38m\]"
CYAN="\[\e[0;96m\]"


ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
parse_git_dirty() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY${ref#refs/heads/}"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN${ref#refs/heads/}"
  fi
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

setopt PROMPT_SUBST
PROMPT='%9c%{%F{magenta}%}$(parse_git_branch)%{%F{none}%} $ '

# PROMPT='%{$fg_bold[red]%}%m%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
# RPROMPT='%{$reset_color%} %{$fg[yellow]%}$(git_prompt_info) %{$reset_color%}'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
