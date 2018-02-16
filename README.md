# My trusty vim environment
## What's inside
Configuration that makes C++ development a little bit easier for brave people using xterm + tmux + vim setup.
Features:
* Basic development settings: tabs, spaces, etc
* Plugin settings and mappings
* Pathogen and a bunch of plugins set up as git submodules
* xterm settings (to be included into `~/.Xresources`): look, feel and, most importantly, colors

## Installation
1. Clone this repo to your `~/.vim` folder
```
git clone https://github.com/xenzh/myvimrc.git ~/.vim
```
2. Make `.vimrc` symlink
```
ln -s ~/.vim/.vimrc ~/.vimrc
```
3. Include `.xterm` to your `.Xresources` or `.Xdefaults` (just add following line at the end of the file)
```
#include ".vim/.xterm"
```
4. Reload `.Xresources` or `.Xdefaults`
```
xrdb -load ./.Xresources
```
5. Restart xterm session and have fun!

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

## Details
Too lazy, please check .vimrc comments.
