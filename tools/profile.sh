#!/bin/bash

THISDIR=$(dirname "$0")
export RIPGREP_CONFIG_PATH="$THISDIR/../.ripgrep"
SHELL="$( echo "$SHELL" | rg -o 'bash|zsh' )"


# common aliases

alias c=clear
alias l="ls -lahH --group-directories-first"
alias cl="c && l"
alias x="xterm -uc -en en_US.UTF8"
alias :e="vim"


# git aliases, autocomplete and PS1

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

if [ "$SHELL" = "bash" ]; then
    if [[ "$(type -t __git_complete)" == "function" ]]; then
        PS1='\[\e]0;\u@\h:\w\a\][\u@\h \W$(__git_ps1 " (%s)")]\$ '

        __git_complete gc _git_checkout
        __git_complete gb _git_branch
        __git_complete gd _git_diff
        __git_complete gpo _git_branch
        __git_complete gpl _git_branch
    fi
fi


# fzf convenience functions
if [ -x "$(command -v highlight)" ]; then
    fzf_preview_cmd="highlight --quiet -O xterm256 {1} -s moria || head -100 {1}"
else
    fzf_preview_cmd="head -100 {1}"
fi

vimf() {
    if [ -z "$1" ]; then
        loc=$(fzf)
    else
        cwd=$PWD
        cd "$1" || return
        loc=$(fzf)
        if [ -n "$loc" ]; then
            loc="$1/$loc"
        fi
        cd "$cwd" || return
    fi

    if [ -n "$loc" ]; then
        vim "$loc"
    fi
}

vimg() {
    cwd=$PWD
    if [ -n "$2" ]; then
        cd "$2" || return
    fi
    matches=$(
        rg --vimgrep $1 |
        awk -F: -v OFS=" " '{print $1,$2,$4}' |
        fzf --preview="$fzf_preview_cmd | sed -n '{2},+100p'")

    loc=$(echo "$matches" | awk '{print $1}')
    offset=$(echo "$matches" | awk '{print $2}')

    if [ -n "$loc" ]; then
        if [ -n "$2" ]; then
            loc="$2/$loc"
            cd "$cwd" || return
        fi

        vim "$loc" "+$offset"
    fi
}

vimh() {
    loc=$(grep '^>' ~/.viminfo | cut -c3- | sed 's,~,'"$HOME"',' | fzf)
    if [ -n "$loc" ]; then
        vim "$loc"
    fi
}

cdf() {
    loc=$(
        find . -type d -not -path '*/\.*' |
        fzf --preview='ls -ahH --group-directories-first --color {}')
    cd "$loc" || return
}


# other functions

comms() {
    a="$1"; shift
    b="$1"; shift
    comm <(sort "$a") <(sort "$b") "$@"
}

listcolors() {
    for i in {0..255} ; do
        printf "\\x1b[38;5;%smcolour%s\\n" "${i}" "${i}"
    done
}


# highlight: better less, fzf preview

if [ -x "$(command -v highlight)" ]; then
    export LESSOPEN="| $(command -v highlight) %s --out-format xterm256 -l --force -s moria --no-trailing-nl"
    export LESS=" -R"
    alias less='less -m -N -g -i -J --line-numbers --underline-special'
fi


# fzf config

if [ -x "$(command -v rg)" ]; then
    export FZF_DEFAULT_COMMAND="rg --hidden -l -g '!.git' ''"
else
    export FZF_DEFAULT_COMMAND='find * -type f'
fi

fzf_colors="dark,fg:249,bg:235,hl:110,fg+:249,bg+:237,hl+:110,info:150,prompt:110,pointer:110,marker:110,spinner:110,header:24"
export FZF_DEFAULT_OPTS="-m --preview='$fzf_preview_cmd' --preview-window right:60% --color=$fzf_colors"
