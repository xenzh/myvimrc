set runtimepath^=~/.dotfiles runtimepath+=~/.vim/after
let packpath = &runtimepath
source ~/.vimrc

:au VimLeave * set gcr=a:ver100-blinkoff0
