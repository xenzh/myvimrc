let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exe 'source ' s:path . '/.vimrc.common'


" syntax highlighting
syntax on


" use standard vim8 package manager
if has('packages')
    exe 'set pp=' . s:path

" fall back to pathogen
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

filetype plugin indent on
