export DISPLAY=:0.0
export CLICOLOR=1

# aliases
alias psx="ps auxw | grep $1"

# display current gh branch
function parse_gitbranch {
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf "%s" "${b##refs/heads/}";
    fi
}

# define colors
BLACK="\[\e[0;38m\]"
CYAN="\[\e[0;36m\]"
PURPLE="\[\e[0;35m\]"

# set command prompt
PS1="\h:$PURPLE\$(parse_gitbranch) $BLACK\W$ "