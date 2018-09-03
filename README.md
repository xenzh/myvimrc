# My trusty dotfiles

[What's inside](WHATS\_INSIDE.md)
[Mappings and commands](MAPPINGS.md)


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

## Troubleshooting
I had an issue with tmux breaking xterm color scheme for vim.
Fixed it by forcing 256 colors in `.tmux.conf`:
```
set -g default-terminal "screen-256color"
```
`xterm-256colors` should also work, but TMUX FAQ suggests we'd better not set anything but `screen*`

## How to add, remove and update plugins

Use `tools/myvimrc` script. Or, if you prefer to do things manually:

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
See https://gist.github.com/myusuf3/7f645819ded92bda6677 (outdated). Alternatively:
```
cd ./.vim/bundle
rm -rf ./plugin
cd ..
vim .gitmodules # find and remove plugin section
git add .
git commit -m "removed X plugin"
```

## Also
Little optional magic to `~/.bashrc`:
```
PS1='\[\e]0;\u@\h:\w\a\][\u@\h \W$(__git_ps1 " (%s)")]\$ '
```
