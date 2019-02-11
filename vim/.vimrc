let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" load basic settings
exe 'source ' s:path . '/.vimrc.common'


if has("packages")
    call PackAdd('vim-airline')
endif


" enable syntax highlighting and filetype plugins
syntax on
filetype plugin indent on
