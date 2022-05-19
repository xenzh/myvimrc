# My trusty dotfiles

Features:

* `zsh` configuration (based on `oh-my-zsh`).
* `tmux` configuration.
* `vim`/`nvim` configuration and plugins for C++/python/Rust development.
* shell aliases and tools.

Documentation:

* [What's inside](docs/WHATS\_INSIDE.md)
* [Mappings and commands](docs/MAPPINGS.md)

![tmux and vim, nord theme, cpp](./docs/myvimrc-nord.png)

## Installation

1. Clone this repo to `~/.dotfiles` folder and get the submodules

```
git clone https://github.com/xenzh/myvimrc.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive --remote
```

2. Install [nord theme](https://www.nordtheme.com/) port for the terminal emulator.

3. Make symlinks / source scripts

```
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.zshrc ~/.zshrc
source ~/.dotfiles/tools/profile.sh
```


## How to add, remove and update submodules

```sh
# add a plugin (use to http to bypass corp MITM)
git submodule add http://<git_repo>

# pull all submodules
git submodule update --init --recursive --remote

# remove a submodule
git submodule deinit -f -- "vim/bundle/$1"
rm -rf ".git/modules/vim/bundle/$1"
git rm -f "vim/bundle/$1"
```
