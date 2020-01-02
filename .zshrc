thisdir="$( cd "$(dirname ${(%):-%N})" > /dev/null && pwd)"

export ZSH=$thisdir/zsh/oh-my-zsh
ZSH_CUSTOM=$ZSH/../custom


ZSH_THEME="geometry/geometry"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"


plugins=(
  z
  fzf
  git
  dirhistory
  docker
  pip
  python
  tmux
  vscode
  web-search
  zsh-interactive-cd
  zsh-autosuggestions
  zsh-syntax-highlighting
)


ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

# Geometry theme customizations
# 1. Bring back custom git details separator
GEOMETRY_GIT_SEPARATOR=' :: '

geometry_git_custom() {
  (( $+commands[git] )) || return

  local git_dir; git_dir=$(git rev-parse --git-dir 2>&1) || return
  pushd -q "$git_dir"/..

  $(command git rev-parse --is-bare-repository 2>/dev/null) \
    && ansi ${GEOMETRY_GIT_COLOR_BARE:=blue} ${GEOMETRY_GIT_SYMBOL_BARE:="⬢"} \
    && return

  local git_info && git_info=(
    $(geometry_git_conflicts)
    $(geometry_git_time)
    $(geometry_git_stashes)
    $(geometry_git_status)
  )

  echo -n $(geometry_git_symbol) $(geometry_git_branch) ${(ej.${GEOMETRY_GIT_SEPARATOR:- }.)git_info}
  popd -q 2>/dev/null
}

# 2. Customize promts to include git separator fix and docker hostname
GEOMETRY_RPROMPT=(geometry_exec_time geometry_git_custom geometry_echo)
GEOMETRY_INFO=(geometry_hostname geometry_docker_machine geometry_jobs)


# expand and complete all wildcards before cursor
bindkey TAB expand-or-complete-prefix


# User configuration

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
export SSH_KEY_PATH="~/.ssh/rsa_id"

autoload -U zmv
alias mmv='noglob zmv -W'

source $thisdir/tools/profile.sh
