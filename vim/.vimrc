"
" Basic config
"


" enable mouse
" Shift-select to X-yank, Shift+Wheel to X-paste
set mouse=a


" leader key is space
let g:mapleader=" "


" utf-8 everywhere
scriptencoding utf-8
set encoding=utf-8


" custom runtimepath for vim folder
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
exe 'set rtp=' . &rtp . ',' . s:path


" allow secure per-project .vimrc
set exrc
set secure


" backups and swap files
set nobackup
set nowb
set noswapfile


" newline
set wrap
set ai


" search
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic


" plugin trigger delay
set updatetime=750


" load ctags (recursive downtop)
set tags+=./tags;/


" wild menu and completion options
set wildmenu
set wildignore+=*.o,*.d,*.pyc
set completeopt=longest,menuone,preview,noselect


" syntax highlighting
syntax on
set cursorline


" tabs, indents, line numbers, backspace, disable bell
set smarttab
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4
set ruler
set number
set showmatch
set backspace=indent,eol,start
set visualbell
set vb t_vb=""


" splits are to the right and at the bottom
set splitright
set splitbelow


" folds
set foldmethod=syntax
set foldlevelstart=99


" views: don't save cwd and folds
set viewoptions-=options,folds


" show special chars
set list
set listchars=tab:→→,trail:·,space:·


" 256 color terminal
set term=xterm-256color
set background=dark


" colorscheme and color overrides
function! OverrideColors()
    hi SpecialKey ctermfg=darkgray
    hi TabLineSel ctermfg=darkgray

    " ALE
    hi link ALEWarning SpellLocal

    " sneak
    hi link Sneak WildMenu
    hi link SneakScope WildMenu
    hi link SneakLabel WildMenu

    " vim-bookmarks
    hi BookmarkSign ctermbg=237 ctermfg=79
    hi BookmarkLine ctermbg=237 ctermfg=79
    hi BookmarkAnnotationSign ctermbg=237 ctermfg=79
    hi BookmarkAnnotationLine ctermbg=237 ctermfg=79
endfunction

augroup ColorOverrides
    au!
    au ColorScheme * call OverrideColors()
augroup END

colorscheme bubblegum-256-dark


" package management setup

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
