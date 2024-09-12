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
  fzf                     # auto-competion, Ctrl-T: file in dir, Ctrl-R: command history, Alt-C: cd
  gitfast                 # fast completion for `git` command.
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


ZSH_THEME=""

export TYPEWRITTEN_PROMPT_LAYOUT="pure"
export TYPEWRITTEN_RELATIVE_PATH="home"
export TYPEWRITTEN_CURSOR="terminal"
export TYPEWRITTEN_ARROW_SYMBOL="⏤ "
export TYPEWRITTEN_COLOR_MAPPINGS="primary:blue;accent:green"
export TYPEWRITTEN_COLORS="arrow:magenta;git_branch:magenta"

fpath+=$ZSH_CUSTOM/themes/typewritten
autoload -U promptinit; promptinit
prompt typewritten


ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'


# expand and complete all wildcards before cursor
bindkey TAB expand-or-complete-prefix


# User configuration

export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"

autoload -U zmv
alias mmv='noglob zmv -W'

source $thisdir/tools/profile.sh
