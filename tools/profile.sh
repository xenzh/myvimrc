#!/bin/bash

mydir=$(dirname "$0")
export RIPGREP_CONFIG_PATH="$mydir/../.ripgrep"

myshell="$( ps -p "$$" | rg -o 'bash|zsh' )"


#
# common aliases
#

alias c=clear
alias l="ls -lahH --group-directories-first"
alias cl="c && l"
alias rmd="rm -rf"
alias duh="du -d 1 -h"
alias x="xterm -uc -en en_US.UTF8 -lcc $(which luit)"
alias :e="vim"
alias vi="vim -u NONE"

function gdbi() {
    gdb-add-index "$1"
    gdb --args "$@"
}

if [ -x "$(command -v highlight)" ]; then
    export LESSOPEN="| $(command -v highlight) %s --out-format xterm256 -l --force -s moria --no-trailing-nl"
    export LESS=" -R"
    alias less='less -m -N -g -i -J --line-numbers --underline-special'
fi



#
# git aliases, autocomplete and PS1
#

alias vimrc="vim $mydir/../vim/.vimrc"

alias g="git"
alias gs="git status --ignore-submodules=dirty"
alias gc="git checkout"
alias gcm="git checkout master"
alias gcb="git checkout -b"
alias gmm="git merge master"
alias gsu="git fetch upstream && git checkout master && git merge upstream/master && git push origin master"
alias gb="git branch"
alias gd="git diff"
alias gpo="git push origin"
alias gpom="git push origin master"
alias grpo="git remote prune origin"
alias ggc="git gc --aggressive --prune=now"

alias gl="git log --oneline --color=always | fzf --ansi --preview='git show --color=always {1}' | rg '^(\\S+)' -o"
alias gr="gl | awk '{print \$1}' | xargs git rebase -i"

alias gbf="git branch | fzf --preview='git diff --color=always master {1}'"
alias gcf="gbf | xargs git checkout"


if [ "$myshell" = "bash" ]; then
    if [[ "$(type -t __git_complete)" == "function" ]]; then
        PS1='\[\e]0;\u@\h:\w\a\][\u@\h \W$(__git_ps1 " (%s)")]\$ '

        __git_complete gc _git_checkout
        __git_complete gb _git_branch
        __git_complete gd _git_diff
        __git_complete gpo _git_branch
        __git_complete gpl _git_branch
    fi
fi


#
# fzf config
#

alias cb="cargo build"
alias cba="cargo build --all"
alias ct="cargo test"
alias cr="cargo run"
alias cbr="cargo build --all && cargo run"


#
# fzf config
#

fzf_preview="$mydir/preview"
fzf_preview_cmd="$fzf_preview {}"

if [ -x "$(command -v rg)" ]; then
    export FZF_DEFAULT_COMMAND="rg --hidden -l -g '!.git' ''"
else
    export FZF_DEFAULT_COMMAND='find * -type f'
fi

fzf_colors="dark,fg:249,bg:235,hl:110,fg+:249,bg+:237,hl+:110,info:150,prompt:110,pointer:110,marker:110,spinner:110,header:24"
export FZF_DEFAULT_OPTS="-m --preview='$fzf_preview_cmd' --preview-window right:60% --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:preview-down,ctrl-k:preview-up --color=$fzf_colors"



#
# fzf convenience functions
#

vimf() {
    if [ -z "$1" ]; then
        loc=$(fzf | awk -v ORS=' ' '{print}')
    else
        cwd=$PWD
        cd "$1" || return
        loc=$(fzf)
        if [ -n "$loc" ]; then
            loc=$(echo "$loc" | awk -v ORS=' ' -v basepath="$1" '{print basepath "/" $0}')
        fi
        cd "$cwd" || return
    fi

    if [ -n "$loc" ]; then
        vim $(echo "$loc") # split args. don't do xargs vim, it breaks the terminal!
    fi
}

vimg() {
    cwd=$PWD
    if [ -n "$2" ]; then
        cd "$2" || return
    fi
    matches=$(
        rg --vimgrep "$1" |
        awk -F: -v OFS=" " '{print $1,$2,$4}' |
        fzf +m --preview="$fzf_preview {1} {2}")

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
    loc=$(find . -type d -not -path '*/\.*' | fzf)
    cd "$loc" || return
}

lf() {
    loc=$(find . -type d -not -path '*/\.*' | fzf)
    l "$loc" || return
}


unalias z 2> /dev/null
if [ "$myshell" = "zsh" ]; then
    z() {
      if [[ -z "$*" ]]; then
        cd "$(_z -l 2>&1 | fzf +s --tac --preview="$fzf_preview {2}" | sed 's/^[0-9,.]* *//')" || exit 1
      else
        _last_z_args="$*"
        _z "$@"
      fi
    }

    compctl -U -K _z_zsh_tab_completion z

    zz() {
      cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")" || exit 1
    }
fi


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
