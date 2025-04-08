#!/bin/bash

mydir=$(dirname "$0")
export MYVIMRC_ROOT_PATH="$mydir/.."
export RIPGREP_CONFIG_PATH="$MYVIMRC_ROOT_PATH/.ripgrep"
export PATH="$PATH:$mydir"

myshell="$( ps -p "$$" | grep -o 'bash\|zsh' )"


#
# common aliases
#

alias q=exit
alias c=clear
alias l="ls -lahH --group-directories-first --color=auto"
alias lt="l -t"
alias cl="c && l"
alias ch="c && tmux clear-history"
alias duh="du -d 1 -h"
alias bell="echo -e '\07'"

if command -v nvim > /dev/null 2>&1; then
    edit() { nvim "$@" }

    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias gvim="vin"

    if command -v neovide > /dev/null 2>&1; then
        vin() { neovide --multigrid --notabs "$@" }
    fi
else
    edit() { vim "$@" }
fi

alias :e="vim"
alias vi="vim -u $mydir/../vim/.vimrc.min"


export BAT_THEME="Nord"
export BAT_STYLE="numbers,changes"

if [ -x "$(command -v bat)" ]; then
    alias less='bat'
fi


www() {
    if [ -x "$(command -v lynx)" ]; then
        lynx "$1"
    else
        echo "lynx is not installed"
    fi
}

cpp() {
    www "https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search=$1"
}



#
# git aliases, autocomplete and PS1
#


alias g="git"
alias gs="git status --ignore-submodules=dirty"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gd="git diff"
alias gpo="git push origin"
alias gpu="git push upstream"
alias grpo="git remote prune origin"
alias ggc="git gc --aggressive --prune=now"

alias gl="git log --oneline --color=always | fzf --ansi --preview='git show --color=always {1}' | rg '^(\\S+)' -o"
alias gll="git log --graph --color --oneline --decorate --all"
alias gr="gl | awk '{print \$1}' | xargs git rebase -i"

alias gcd='cd $(git rev-parse --show-toplevel)'

gbn()  { git rev-parse --abbrev-ref HEAD }
gbb()  { git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@' }
gbs()  { echo "Unique commits in $(gbb) / $(gbn):" && git rev-list --left-right --count "$(gbb)".."$(gbn)" }
gbl()  {
    git rev-list --left-right --pretty=oneline "$(gbb)".."$(gbn)" |
        awk -v l="$(gbb)" -v r="$(gbn)" '{if (substr($0,1,1)==">") d=l; else d=r; print "[",d,"] --",substr($0,2)}'
}

alias gbd="git branch -d"
alias gbdd="git branch -D"

gcm()  { git checkout "$(gbb)" }
gmm()  { git merge "$(gbb)" }
gsu()  { git fetch upstream && git checkout "$(gbb)" && git merge upstream/"$(gbb)" && git push origin "$(gbb)" && git pull }
gpom() { git push origin "$(gbb)" }

gbf()  { git branch | fzf --preview="git diff --color=always $(gbb) {1}" }
gcf()  { gbf | xargs git checkout }


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
# C++ config and aliases
#

export CMAKE_GENERATOR="Ninja"
alias nj="ninja"


#
# docker aliases
#

alias di="docker images"
alias did="docker rmi"

alias dc="docker ps -a"
alias dcd="docker rm"
alias dcp="docker container prune"
alias drm="docker container ls -a | awk '!/NAMES/ {print \$NF}' | fzf --preview='docker container logs {}' | xargs docker rm -f"


alias dv="docker volume ls"
alias dvd="docker volume rm"
alias dvp="docker system df -v | grep \"VOLUME NAME\" -A 999 | awk '\$3 == \"0B\" {print \$1}' | xargs docker volume rm"

dvc() {
    docker volume create --name "$2"
    docker run --rm -it -v "$1:/from" -v "$2:/to" alpine ash -c "cd /from && cp -av . /to"
}

alias dr="docker run"
alias db="docker build"
alias ds="docker stats"
alias dss="dvp > /dev/null 2>&1 ; docker system df -v"

alias dalp="docker run --rm -it alpine:latest ash"


#
# rust/cargo config
#

alias cb="cargo build"
alias ccb="c && cb"
alias cba="cargo build --all"
alias cv="cargo test"
alias cx="cargo run"
alias xcv="cargo build --all && cargo run"


#
# fzf config
#

fzf_preview="$mydir/preview"
fzf_preview_cmd="$fzf_preview {}"

if [ -x "$(command -v rg)" ]; then
    export FZF_DEFAULT_COMMAND="rg --hidden -l -g '!.git' -g '!*.o' -g '!*.d' ''"
else
    export FZF_DEFAULT_COMMAND="find * -type f | grep -v '.git\|\.d$\|\.o$'"
fi

fzf_colors="bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"
export FZF_DEFAULT_OPTS="-m --preview='$fzf_preview_cmd' --preview-window right:60% --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:preview-down,ctrl-k:preview-up --color=$fzf_colors"


#
# fzf convenience functions
#

editf() {
    if [ -z "$2" ]; then
        loc=$(fzf | awk -v ORS=' ' '{print}')
    else
        cwd=$PWD
        cd "$2" || return
        loc=$(fzf)
        if [ -n "$loc" ]; then
            loc=$(echo "$loc" | awk -v ORS=' ' -v basepath="$2" '{print basepath "/" $0}')
        fi
        cd "$cwd" || return
    fi

    if [ -n "$loc" ]; then
        "$1" $(echo "$loc") # split args. don't do xargs vim, it breaks the terminal!
    fi
}

editg() {
    cwd=$PWD
    if [ -n "$3" ]; then
        cd "$3" || return
    fi
    matches=$(
        rg --vimgrep "$2" |
        awk -F: -v OFS=" " '{print $1,$2,$4}' |
        fzf +m --preview="$fzf_preview {1} {2}")

    loc=$(echo "$matches" | awk '{print $1}')
    offset=$(echo "$matches" | awk '{print $2}')

    if [ -n "$loc" ]; then
        if [ -n "$3" ]; then
            loc="$3/$loc"
            cd "$cwd" || return
        fi

        "$1" "$loc" "+$offset"
    fi
}

__get_oldfile_from_cmd() {
    loc=""
    if command -v nvim; then
        loc=$(nvim --headless +':new +setl\ buftype=nofile | 0put =v:oldfiles' +'w >> /dev/stdout' +qa!)
    else
        loc=$(grep '^>' ~/.viminfo | cut -c3- | sed 's,~,'"$HOME"',')
    fi
    echo "$loc"
}

edith() {
    loc=$(__get_oldfile_from_cmd | grep -v 'nvim$' | fzf)
    if [ -n "$loc" ]; then
        "$1" "$loc"
    fi
}

editl() {
    loc=$(__get_oldfile_from_cmd | grep -v 'nvim$' | head -1 | fzf -1)
    if [ -n "$loc" ]; then
        "$1" "$loc"
    fi
}

vimf() { editf edit "$@" }
vimg() { editg edit "$@" }
vimh() { edith edit "$@" }
viml() { editl edit "$@" }

vinf() { editf vin "$@" }
ving() { editg vin "$@" }
vinh() { edith vin "$@" }
vinl() { editl vin "$@" }


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
        cd "$(zshz -l 2>&1 | fzf +s --tac --preview="$fzf_preview {2}" | sed 's/^[0-9,.]* *//')" || exit 1
      else
        _last_z_args="$*"
        zshz "$@"
      fi
    }

    compctl -U -K _z_zsh_tab_completion z

    zz() {
      cd "$(zshz -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")" || exit 1
    }
fi


# ls colors

if [ -x "$(command -v gdircolors)" ]; then
    eval 'gdircolors $mydir/external/nord-dircolors/src/dir_colors' > /dev/null 2>&1
elif [ -x "$(command -v dircolors)" ]; then
    eval 'dircolors $mydir/external/nord-dircolors/src/dir_colors' > /dev/null 2>&1
fi


# external tools

interactively() {
    "$mydir/external/interactively/bin/interactively" "$@"
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

italic() {
    echo `tput sitm`italics`tput ritm`
}

install_italic_for_tmux() {
cat <<EOF|tic -x -
tmux|tmux terminal multiplexer,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  use=xterm+tmux, use=screen,

tmux-256color|tmux with 256 colors,
  use=xterm+256setaf, use=tmux,
EOF
}

cing() {
    curl --connect-timeout 1 -Is "$1" > /dev/null && echo "$1: ok" || echo "$1: fail"
}
