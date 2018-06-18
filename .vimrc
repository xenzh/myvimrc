"
" MY Vimrc, one and only
"
"
" Plugins:
" * pathogen
"   Runtime path manager (.vim/bundle plugin autoload)
"   https://github.com/tpope/vim-pathogen
"
" * vim-localvimrc
"   Search .lvimrc files from pwd up to root and source them in
"   https://github.com/embear/vim-localvimrc
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
" * [DISABLED] ctrlp
"   fuzzy search palette for files, recently opened files and buffers
"   poor performance, switched default setup to use fzf.vim
"   https://github.com/ctrlpvim/ctrlp.vim
"
" * fzf, fzf.vim
"   Search for files, tags and more based on fzf command-line tool
"   https://github.com/junegunn/fzf
"   https://github.com/junegunn/fzf.vim
"
" * vim-bookmarks
"   visual bookmarks and annotations
"   https://github.com/MattesGroeger/vim-bookmarks
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
" * ctags (code navigation. exuberant-ctags preferred)
" * fzf (command-line fuzzy finder)
" * git (vim-airline, branch and status; fugitive integration)
" * clang (C++ syntax check)
" * cargo, rustc (Rust syntax check)
" * rustfmt, rls, racer (via rustup; Rust formatting and code completion)
" * xmllint (XML formatting)
" * jq (Json formatting; there's also a python-based solution, see below)
"
" Generated files:
" * .clang - simple file with -I compiler flags, clang.vim uses it to locate headers
" * tags - ctags output file, used for code navigation
"
" How to generate tags:
" ctags -R <project folder>
"
" You might want to update .Xdefaults/.Xresources for better experience of using vim in xterm




"
" Basic config
"

" enable mouse
" Shift+Wheel to X-paste from x clipboard!
set mouse=a


" use utf-8 everywhere
scriptencoding utf-8
set encoding=utf-8


" use per-directory .vimrc-s
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


" simple menu and word autocompletion
set wildmenu
set wildignore+=*.o,*.pyc

set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" syntax highlighting
syntax on
filetype plugin indent on
set cursorline


" tabs, indents, line numbers, backspace and bell
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


" show special chars
set list
set listchars=tab:→→,trail:·,space:·


" color scheme and tweaks
set term=xterm-256color
set background=dark
colorscheme bubblegum-256-dark
hi SpecialKey ctermfg=darkgray " should be set after set listchars and colorscheme
hi TabLineSel ctermfg=darkgray

" vim-bookmarks
highlight BookmarkSign ctermbg=237 ctermfg=79
highlight BookmarkLine ctermbg=237 ctermfg=79

highlight BookmarkAnnotationSign ctermbg=237 ctermfg=79
highlight BookmarkAnnotationLine ctermbg=237 ctermfg=79

set vb t_vb="" " Disable screen flashing on error




"
" Shortcuts and commands
"


" I like to hold Shift for a bit longer than necessary
command W :w
command Q :q
command Wq :wq
command WQ :wq


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

function ClearCheckSyntaxResults()
  execute 'SyntasticReset'
endfunction
command C call ClearCheckSyntaxResults()

" toggle space chars visibility
function! DoToggleSpaceChars()
  set list!
  set number!
endfunction

command ToggleSpaceChars :call DoToggleSpaceChars()
nmap <F6> :ToggleSpaceChars<CR>


" close all buffers but this
command O %bd | e#


" open this buffer in vertical split and switch left side to prev buffer
command Vs :vs | bd
command Js :% | y | vn | setf json | Fmt


" list all highlight groups
command Hi :so $VIMRUNTIME/syntax/hitest.vim




"
" Common plugins config
"


" pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on


" localvimrc
let g:localvimrc_name = ["~/.lvimrc"]
let g:localvimrc_event = ["VimEnter"]
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0


" load ctags (recursive downtop)
set tags+=./tags;/


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
let g:tagbar_autofocus = 1
nmap <F8> :TagbarToggle<CR>


" nerdtree, start it in case vim opened on a folder
nmap <F7> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif


" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['tag', 'dir']

let g:ctrlp_lazy_update = 350
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0

if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --hidden -g ""'
endif

"nmap [p :CtrlPMixed<CR>
"nmap ]p : CtrlPBufTagAll<CR>
"nmap ][p :CtrlPTag<CR>


" fzf.vim
function LocalTags()
    let old_tags=&tags
    set tags=./tags;/
    execute ':Tags'
    let &tags=old_tags
endfunction

nmap [p :Files<CR> " files in this repo
nmap ]p :call LocalTags()<CR> " tags in this folder tree
nmap ][p :Tags<CR> " all tags


" vim-bookmarks
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_save_per_working_dir = 0
let g:bookmark_manage_per_buffer = 0
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_center = 1

let g:bookmark_disable_ctrlp = 1 " or ma in ctrlp list (not sorted!)
let g:bookmark_location_list = 0 " quickfix or location list

nmap ml <Plug>BookmarkShowAll


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

