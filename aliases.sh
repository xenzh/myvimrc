#!/bin/sh

alias c=clear
alias l="ls -laH --block-size=human-readable"
alias cl="c && l"
alias x="xterm -uc -en en_US.UTF8"
alias :e="vim"

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
alias gp="git remote prune origin"

__git_complete gc _git_checkout
