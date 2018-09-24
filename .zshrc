# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_DISABLE_COMPFIX=true

#ZSH_TMUX_AUTOSTART=true # fix EOD toolkit connections!
ZSH_AUTOSUGGEST_HIGHLIGHT_TYPE='fg=103'


export ZSH=$HOME/.vim/oh-my-zsh
ZSH_CUSTOM=$ZSH/../oh-my-zsh-custom

#ZSH_THEME="avit"
#ZSH_THEME="theunraveler"
#ZSH_THEME="wezm"
ZSH_THEME="geometry/geometry"

# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# CASE_SENSITIVE="true"

HYPHEN_INSENSITIVE="true"

# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


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

source $ZSH/oh-my-zsh.sh


# User configuration

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
# export SSH_KEY_PATH="~/.ssh/rsa_id"

source ~/.vim/tools/profile.sh
