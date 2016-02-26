export DISPLAY=:0.0
export CLICOLOR=1

# aliases
alias psx="ps auxw | grep $1"
alias gst='git status '

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local gitcolour="$CYAN"
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local gitcolour="$YELLOW"
        else
            local gitcolour="$GREEN"
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
	if [ -n "$branch" ]; then
	    echo "$gitcolour $branch \n";
	fi
    fi
}

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

# set command prompt
#PS1="\h:$PURPLE\$(parse_gitbranch) $BLACK\W$ "

function _prompt_command() {
    PS1="$PINK\u $BLUE\w `_git_prompt`$PINK>> $BLACK"
}

export PROMPT_COMMAND=_prompt_command
