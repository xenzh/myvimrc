let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" load basic settings
exe 'source ' s:path . '/.vimrc.common'

function! LoadOptPackages()
    if has("packages")
        call PackAdd('vim-airline')
        call PackAdd('vim-airline-themes')
        call PackAdd('ale')
        call PackAdd('async.vim')
        call PackAdd('asyncomplete.vim')
        call PackAdd('asyncomplete-buffer.vim')
        call PackAdd('asyncomplete-file.vim')
        call PackAdd('asyncomplete-tags.vim')
        call PackAdd('asyncomplete-lsp.vim')
        call PackAdd('nerdcommenter')
        call PackAdd('rust.vim')
        call PackAdd('tagbar')
    endif
endfunction

au! VimEnter * call LoadOptPackages()


" enable syntax highlighting and filetype plugins
syntax on
filetype plugin indent on
