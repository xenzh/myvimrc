thisdir="$( cd "$(dirname ${(%):-%N})" > /dev/null && pwd)"

export ZSH=$thisdir/oh-my-zsh/oh-my-zsh
ZSH_CUSTOM=$ZSH/../custom


ZSH_THEME="geometry/geometry"

HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"


plugins=(
  git
  aws
  dirhistory
  docker
  pip
  python
  tmux
  zsh-autosuggestions
  zsh-syntax-highlighting
)


ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'


# User configuration

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
# export SSH_KEY_PATH="~/.ssh/rsa_id"

source $thisdir/tools/profile.sh
