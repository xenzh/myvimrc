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

    " directly source preload stuff
    exe 'source ' . s:path . '/pack/0-preload/start/config/plugin/plugins.vim'

    " populate runtimepath with plugins locations
    call pathogen#infect(s:path . '/pack/2-bundle/start/{}', s:path . '/pack/2-bundle/opt/{}')

    " source order-insensitive user settings directly
    let s:config_path = s:path . '/pack/4-mine/start/config/'
    exe 'source ' . s:config_path . 'plugin/mappings.vim'
    exe 'source ' . s:config_path . 'plugin/plugins.vim'

    " populate runtimepath with 'after' location (user ftplugins and postload stuff)
    exe 'set rtp=' . &rtp . ',' . s:config_path . 'after'
endif

filetype plugin indent on
