# My trusty dotfiles

* [What's inside](WHATS\_INSIDE.md)
* [Mappings and commands](MAPPINGS.md)


## Installation
1. Clone this repo to your `~/.vim` folder and download the plugins
```
git clone https://github.com/xenzh/myvimrc.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
```
2. Make `.vimrc` symlink
```
ln -s ~/.vim/.vimrc ~/.vimrc
```
3. Make `.tmux.conf` symlink
```
ln -s ~/.vim/.tmux.conf ~/.tmux.conf
```
4. Include `.xterm` to your `.Xresources` or `.Xdefaults` (just add following line at the end of the file)
```
#include ".vim/.xterm"
```
5. Reload `.Xresources` or `.Xdefaults`
```
xrdb -load ./.Xresources
```
6. Source profile tweaks (just add following line to your `.bashrc`)
```
source ~/.vim/tools/profile.sh
```
7. Restart xterm session and have fun!

## How to add, remove and update plugins

Use `tools/myvimrc` script.
