#!/bin/bash


DOTFILES="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


function fail() {
    echo "$1"
    exit 1
}

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}


echo "1. Downloading and initializing git submodules"

if ! command -v git &> /dev/null; then
    echo "git cannot be find"
    exit 1
fi

yes_or_no "Download submodules" && git submodule update --init --recursive --remote || fail "Failed to initialize submodules"


echo "2. Installing vim/nvim config"

ln -s "$DOTFILES/vim/.vimrc" ~/.vimrc

mkdir -p ~/.config/nvim
cp "$DOTFILES/vim/init.vim" ~/.config/nvim


echo "3. Installing tmux config"

touch ~/.tmux.conf
TMUX_SOURCEFILE="source-file $DOTFILES/tmux/.tmux.conf"

if grep -Fxq "$TMUX_SOURCEFILE" ~/.tmux.conf; then
    echo "Tmux config is already sourced"
else
    echo -e "$TMUX_SOURCEFILE\n" | cat - ~/.tmux.conf > temp && mv temp ~/.tmux.conf
fi


echo "4. Installing zsh config"

touch ~/.zshrc
ZSH_SOURCE="source $DOTFILES/.zshrc"

if grep -Fxq "$ZSH_SOURCE" ~/.zshrc; then
    echo "Zsh config is already sourced"
else
    echo -e "$ZSH_SOURCE\n" | cat - ~/.zshrc > temp && mv temp ~/.zshrc
fi


echo "5. Installing necessary tools"

function package() {
    if command -v apt-get &> /dev/null; then
        apt-get install -q=2 $1 || echo "Package not found. Install manually: $1"
    else
        echo "No known package manager found. Install manually: $1"
    fi
}

function python() {
    if command -v pip3 &> /dev/null; then
        pip3 install $1
    else
        echo "No pip3 found. Install manually: $1"
    fi
}

function install_list() {
    for PACKAGE in "${@:2}"; do
        $1 $PACKAGE
    done
}

if command -v apt-get &> /dev/null; then
    apt-get update
fi

TOOLS=(
    zsh
    tmux
    vim
    nvim
    ripgrep
    fzf
    universal-ctags
    python3
    python3-venv
    python3-pip
)

install_list package ${TOOLS[@]}

EXTRA=(
    bat
    jq
    xmllint
    xxd
    thefuck
)

yes_or_no "Install extra packages: ${EXTRA[@]}" && install_list package ${EXTRA[@]}

CPP=(
    clang
    clangd
    gdb
)

yes_or_no "Install C++ packages: ${CPP[@]}" && install_list package ${CPP[@]}

PYTHON=(
    python-language-server
    black
    flake8
    mypy
)

yes_or_no "Install python modules: ${PYTHON[@]}" && install_list python ${PYTHON[@]}


echo "6. Changing login shell"

yes_or_no "Change login shell to zsh" && chsh -s "$(which zsh)"
