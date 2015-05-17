"
" Common developer settings
"

" Enable directory-specific vimrc
set exrc
set secure

" Tab settings
set tabstop=4
set shiftwidth=4
set smarttab
set et

" Newline settings
set wrap
set ai

" Search results highlighting
set showmatch
set hlsearch
set incsearch
set ignorecase

" Non-printable symbols
set listchars=tab:→◦,trail:◦
set list

" Show line numbers
set number

" Codepages order
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,usc-2,cp866

" Allow quick paste from other applications
set pastetoggle=<F2>


"
" GUI
"

" Color scheme
colorscheme darktango
syntax on

" Show max line length ruler
set colorcolumn=100
highlight ColorColumn ctermbg=darkgrey


"
" Pathogen
"
filetype off
call pathogen#helptags()
call pathogen#infect()
filetype plugin indent on


"
" vim-clang and neocomplete
"

let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'

if !exists('g:neocomplete#foce_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:neocomplete#enable_at_startup = 1
let g:clang_cpp_options = '-std=c++11'

