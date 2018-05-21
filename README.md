# My trusty dotfiles
## What's inside
Configuration that makes C++ and Rust development a little bit easier for brave souls using xterm + tmux + vim setup.
Features:
* Basic vim settings: mappings, indents, etc
* Collection of vim plugins for C++/Rust development managed with pathogen and git submodules
* tmux config (mouse mode, colors and tricks)
* xterm config (to be included into `~/.Xresources`): look, feel and, most importantly, colors

## Installation
1. Clone this repo to your `~/.vim` folder
```
git clone https://github.com/xenzh/myvimrc.git ~/.vim
```
2. Make `.vimrc` symlink
```
ln -s ~/.vim/.vimrc ~/.vimrc
```
3. Make `.tmux.conf symlink`
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
6. Restart xterm session and have fun!

## Troubleshooting
I had an issue with tmux breaking xterm color scheme for vim.
Fixed it by forcing 256 colors in `.tmux.conf`:
```
set -g default-terminal "screen-256color"
```
`xterm-256colors` should also work, but TMUX FAQ suggests we'd better not set anything but `screen*`

## How to add, remove and update plugins

### Add
```
cd ~/.vim/bundle
git submodule add url
git add .
git commit -m "added X plugin"
```

### Update
```
cd ~/.vim
git submodule init
git submodule update
git add .
git commit -m "Updated plugins"
```

### Remove
```
cd ./.vim/bundle
rm -rf ./plugin
cd ..
vim .gitmodules # find and remove plugin section
git add .
git commit -m "removed X plugin"
```

## Also
Little magic to `~/.bashrc`:
```
PS1='\[\e]0;\u@\h:\w\a\][\u@\h \W$(__git_ps1 " (%s)")]\$ '

alias ls='ls --color=auto'
alias l="ls -la --color=auto"
alias c=clear
alias cl="clear && ls -la --color=auto"
alias grep="grep --color=always"
alias x="xterm -fullscreen -uc"
```

## Details
Too lazy, please check .vimrc comments.
