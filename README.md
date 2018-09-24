# My trusty dotfiles

* [What's inside](docs/WHATS\_INSIDE.md)
* [Mappings and commands](docs/MAPPINGS.md)


## Installation
1. Clone this repo to your `~/.dotfiles` (ar whatever) folder and download the plugins
```
git clone https://github.com/xenzh/myvimrc.git ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
```
2. Make `.vimrc` symlink
```
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
```
3. Make `.tmux.conf` symlink
```
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```
4. Include `.xterm` to your `.Xresources` or `.Xdefaults` (just add following line at the end of the file)
```
#include ".dotfiles/.xterm"
```
5. Reload `.Xresources` or `.Xdefaults`
```
xrdb -load ./.Xresources
```
6. Source profile tweaks (just add following line to your `.bashrc`)
```
source ~/.dotfiles/tools/profile.sh
```
Or make `.zshrc` symlink
```
ln -s ~/.dotfiles/.zshrc ~/.zshrc
```
7. Restart xterm session and have fun!

## How to add, remove and update vim plugins

Use `tools/myvimrc` script.
