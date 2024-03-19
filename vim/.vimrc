let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" load basic settings
exe 'source ' s:path . '/.vimrc.common'


" setup package management (vim 8 pack by default, fall back to pathogen)
if has('packages')
    if has('nvim')
        exe 'set pp=' . s:path . '/nvim'
    else
        exe 'set pp=' . s:path
    endif
else
    filetype off
    let s:config_path = s:path . '/pack/0-mine/start/config/'

    " populate runtimepath with plugins bundle and user /after locations
    call pathogen#infect(s:path . '/pack/2-bundle/start/{}', s:path . '/pack/2-bundle/opt/{}')
    exe 'set rtp=' . &rtp . ',' . s:config_path . 'after'

    " source order-insensitive user settings directly
    exe 'source ' . s:config_path . 'plugin/mappings.vim'
    exe 'source ' . s:config_path . 'plugin/plugins.vim'
endif


" enable syntax highlighting and filetype plugins
syntax on
filetype plugin indent on
set cc=120

" configure spellcheck
set spelllang=en_gb
exe 'set spellfile=' . s:path . '/spell/en.utf-8.add'
