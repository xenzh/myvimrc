#!/bin/bash

alias c=clear
alias l="ls -lahH --group-directories-first"
alias cl="c && l"
alias x="xterm -uc -en en_US.UTF8"

alias :e="vim"

vimf() {
    if [ -z "$1" ]; then
        loc=$(fzf)
    else
        cwd=$PWD
        cd $1
        loc=$(fzf)
        if [ -n "$loc" ]; then
            loc="$1/$loc"
        fi
        cd $cwd
    fi

    if [ -n "$loc" ]; then
        vim "$loc"
    fi
}

vimag() {
    cwd=$PWD
    if [ -n "$2" ]; then
        cd $2
    fi
    matches=$(ag --nogroup --column --color "$1" | fzf --ansi)
    loc=$(echo "$matches" | ack "^(.*?)\:(\d+):.*" --output "\$1")
    offset=$(echo $matches | ack "^(.*?)\:(\d+):.*" --output "\$2")

    if [ -n "$loc" ]; then
        if [ -n "$2" ]; then
            loc="$2/$loc"
            cd $cwd
        fi

        vim "$loc" "+$offset"
    fi
}

comms() {
    a="$1"; shift
    b="$1"; shift
    comm <(sort "$a") <(sort "$b") "$@"
}

alias g="git"
alias gs="git status"
alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gm="git merge"
alias gmm="git merge master"
alias gmu="git merge upstream/master"
alias gfu="git fetch upstream"
alias gsu="git fetch upstream && git checkout master && git merge upstream/master && git push origin master"
alias gr="git rebase -i"
alias gl="git log"
alias gb="git branch"
alias gd="git diff"
alias gpo="git push origin"
alias gpl="git pull origin"
alias gpom="git push origin master"
alias gplm="git pull origin master"
alias grpo="git remote prune origin"
alias ggc="git gc --aggressive --prune=now"

if [[ "$(type -t __git_complete)" == "function" ]]; then
    __git_complete gc _git_checkout
    __git_complete gb _git_branch
    __git_complete gd _git_diff
    __git_complete gpo _git_branch
    __git_complete gpl _git_branch
fi

export FZF_DEFAULT_COMMAND='ag --hidden -l --ignore .git -g ""'
