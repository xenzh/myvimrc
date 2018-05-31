"
" MY Vimrc, one and only
"
"
" Plugins:
" * pathogen
"   Runtime path manager (.vim/bundle plugin autoload)
"   https://github.com/tpope/vim-pathogen
"
" * a.vim
"   :A switch between associated files (h/cpp)
"   https://github.com/vim-scripts/a.vim
"
" * async.vim, asyncomplete.vim
"   Asynchronous code completion engine
"   https://github.com/prabirshrestha/async.vim
"   https://github.com/prabirshrestha/asyncomplete.vim
"
" * vim-lsp, asyncomplete-lsp
"   Language Server Protocol support and async completion engine bindings
"   https://github.com/prabirshrestha/vim-lsp
"   https://github.com/prabirshrestha/asyncomplete-lsp.vim
"
" * clang.vim
"   C++ syntax checker (per-file) and autocompleter
"   https://github.com/justmao945/vim-clang
"
" * vim-cpp-enhanced-highlight
"   Better C++ code highlighting
"   https://github.com/octol/vim-cpp-enhanced-highlight
"
" * syntastic
"   Syntax checkers
"   https://github.com/vim-syntastic/syntastic
"
" * rust.vim
"   Better syntax highlighting, syntastic checkers and formatter for Rust
"   https://github.com/rust-lang/rust.vim
"
" * csv.vim, vim-json, vim-toml
"   Pretty printers and syntax highlighters for csv, json and toml
"   https://github.com/chrisbra/csv.vim
"   https://github.com/elzr/vim-json
"   https://github.com/cespare/vim-toml
"
" * nerdcommenter
"   block comment/uncomment
"   https://github.com/scrooloose/nerdcommenter
"
" * nerdtree
"   Side pane for filesystem navigation
"   https://github.com/Xuyuanp/nerdtree-git-plugin
"
" * tagbar
"   Side pane, code outline
"   https://github.com/majutsushi/tagbar
"
" * vim-airline, vim-airline-themes
"   Configurable status bar and buffer tabs
"   https://github.com/vim-airline/vim-airline
"   https://github.com/vim-airline/vim-airline-themes
"
" * l9, vim-AutoComplPop
"   Automatic simple text completion
"   https://github.com/vim-scripts/L9
"   https://github.com/vim-scripts/AutoComplPop
"
" * fugitive
"   Git integration (integrated with vim-airline)
"   https://github.com/tpope/vim-fugitive
"
"
" Third-party tools and binaries:
" * ctags (code navigation. exuberant-ctags recommended)
" * git (vim-airline, branch and status)
" * clang (C++ syntax check)
" * cargo, rustc (Rust syntax check)
" * rustfmt, rls, racer (via rustup; Rust formatting and code completion)
" * xmllint (XML formatting)
" * jq (Json formatting; alternatively there's a python-based formatting)
"
" Generated files:
" * .clang - simple file with -I compiler flags, clang.vim uses it to locate headers
" * tags - ctags output file, used for code navigation
"
" codenav.sh (generates ctags):
" #!/bin/sh
" ctags -R .
"
" You might want to update .Xdefaults/.Xresources for better experience of using vim in xterm




"
" Basic config
"

" enable mouse
" Shift+Wheel to X-paste!
set mouse=a


" use utf-8 everywhere
scriptencoding utf-8
set encoding=utf-8


" use per-directory .vimrc-s
set exrc
set secure


" color scheme
set term=xterm-256color " don't let vim override xterm color settings
set background=dark
hi SpecialKey ctermfg=darkgray


" newline
set wrap
set ai


" search
set showmatch
set hlsearch
set incsearch
set ignorecase


" simple word autocompletion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" syntax highlighting
syntax on
filetype plugin indent on


" tabs, indents, line numbers, backspace and bell
set smarttab
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4
set ruler
set number
set backspace=indent,eol,start
set visualbell
set vb t_vb="" " Disable screen flashing on error


" space chars
set list
set listchars=tab:→→,trail:·,space:·




"
" Shortcuts and commands
"


" split resize remappings
nmap <F9>  :resize -3<CR>
nmap <F10> :resize +3<CR>
nmap <F11> :vertical resize -3<CR>
nmap <F12> :vertical resize +3<CR>


" formatting
function! DoFmt()
  if &ft == 'json'
    "%!python -m json.tool
    "%s/\s\s/ /g " replace indent, 4 spaces -> 2 spaces
    %!jq .
  elseif &ft == 'xml'
    %!xmllint --format -
  elseif &ft == 'rust'
    execute 'RustFmt'
  endif
endfunction

command Fmt :call DoFmt()


" syntax check
function! DoCheckSyntax()
  set cmdheight=2
  echom "Syntax check running..."

  if &ft == 'cpp'
    " use vim-clang plugin
    ClangSyntaxCheck
  elseif &ft == 'rust'
    " use syntastic checker provided by rust.vim
    execute 'SyntasticCheck cargo'
    execute 'Errors'
  elseif &ft == 'python'
    execute 'SyntasticCheck'
    execute 'Errors'
  endif

  echom "done!"
  set cmdheight=1
endfunction
nmap <F5> :call DoCheckSyntax()<CR>


" toggle space chars visibility
function! DoToggleSpaceChars()
  set list!
  set number!
endfunction

command ToggleSpaceChars :call DoToggleSpaceChars()
nmap <F6> :ToggleSpaceChars<CR>


" close all buffers but this
command O %bd | e#




"
" Common plugins config
"


" pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on


" load ctags (recursive downtop)
set tags=./tags;/


" vim-airline, buffer tab selection remappings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline_theme='bubblegum'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab


" tagbar
nmap <F8> :TagbarToggle<CR>


" nerdtree, start it in case vim opened on a folder
nmap <F7> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" syntasic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 6

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": []}

let g:syntastic_clang_check_config_file = ".clang"

let g:syntastic_cpp_checkers = []
let g:syntastic_rust_checkers = ['cargo', 'rustc']




"
" C++ plugins config
"


" vim-clang
let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'
let g:clang_include_sysheaders = 1
let g:clang_cpp_options = '-std=c++14'
let g:clang_check_syntax_auto = 0


" neocomplete
if !exists('g:neocomplete#foce_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:neocomplete#enable_at_startup = 1


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1




"
" Rust plugins config
"


" Rust Language Server (via Language Server Protocol completion plugin)
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

