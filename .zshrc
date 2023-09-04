thisdir="$( cd "$(dirname ${(%):-%N})" > /dev/null && pwd)"

export ZSH=$thisdir/zsh/oh-my-zsh
ZSH_CUSTOM=$ZSH/../custom


HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"


plugins=(
  command-not-found       # Suggest package to install
  copybuffer              # Ctrl-O to copy current command to buffer
  copypath                # `copypath` to copy dir to buffer
  dirhistory              # Alt-Left/Right to go up/down dir stack
  docker                  # auto-completion and aliases
  fancy-ctrl-z            # Ctrl-Z to hide vim and Ctrl-Z again to get back to it (instead of `fg`)
  fd                      # auto-completion for fd
  fzf                     # auto-competion, Ctrl-T: file in dir, Ctrl-R: command history, Alt-C: cd
  gitfast                 # fast completion for `git` command.
  ripgrep                 # auto-completion
  rust                    # auto-completion for rustc, rustup, cargo
  tmux                    # Adds tmux aliases and config
  urltools                # Adds urlencode/urldecode commands
  vscode                  # vsc and other commands
  web-search              # web search with many engines
  z                       # jump around recent dirs with `z` and `zz`.
  zbell                   # prints bell after >15s command finishes
  zsh-interactive-cd      # fzf powered tab completion for `cd`
  zsh-autosuggestions     # [custom] command suggestions based on history.
  zsh-syntax-highlighting # [custom] command highlighting
)


ZSH_THEME="geometry/geometry"


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
    $(geometry_git_rebase)
    $(geometry_git_remote)
    $(geometry_git_conflicts)
    $(geometry_git_time)
    $(geometry_git_stashes)
    $(geometry_git_status)
  )

  echo -n $(geometry_git_branch) ${(ej.${GEOMETRY_GIT_SEPARATOR:- }.)git_info}
  popd -q 2>/dev/null
}

# 2. Customize promts to include git separator fix, and some plugins
GEOMETRY_PROMPT=(geometry_newline geometry_status geometry_path)
GEOMETRY_RPROMPT=(geometry_exec_time geometry_git_custom geometry_docker_machine geometry_virtualenv geometry_jobs geometry_echo)


# expand and complete all wildcards before cursor
bindkey TAB expand-or-complete-prefix


# User configuration

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"

autoload -U zmv
alias mmv='noglob zmv -W'

source $thisdir/tools/profile.sh
