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
" * ale
"   Asynchronous multi-language linter, formatter and autocompleter
"   https://github.com/w0rp/ale
"
" * nerdcommenter
"   block comment/uncomment
"   https://github.com/scrooloose/nerdcommenter
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
" * rename
"   Rename file inplace
"   https://github.com/vim-scripts/Rename
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
" * a.vim
"   :A switch between associated files (h/cpp)
"   https://github.com/vim-scripts/a.vim
"
" * vim-cpp-enhanced-highlight
"   Better C++ code highlighting
"   https://github.com/octol/vim-cpp-enhanced-highlight
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
"
" Third-party tools and binaries:
" * git (vim-airline, branch and status; fugitive, git integration)
" * ag (better grep, used by fzf)
" * fzf (command-line fuzzy finder tool)
" * ctags (code navigation. exuberant-ctags recommended)
" * jq (json formatting; see below for python-based option)
" * xmllint (xml formatting)
"
" * clang++ (C++ linting, via ale)
" * clangd/cquery (C/C++ code completion and navigation, used with LSP)
" * bear (https://github.com/rizsotto/Bear) - generating clang compilation databases for clang tools
"
" * cargo, rustc (Rust linting, via ale)
" * rustfmt, rls, racer (Rust formatting and code completion; install with rustup, used by LSP)
"
" * python-language-server (python code completion and navigation, install with pip, used by LSP)
" * pylint/flake8 (python linting, via ale)
"
"
" Other files:
" * .lvimrc - local vim config files
" * .clang - simple file with C++ compiler flags, linter uses it to locate headers
" * compile_commands.json - clang compilation database for clangd/cquery code completion/navigation
" * tags - ctags output file, used for code navigation
"




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


" load ctags (recursive downtop)
set tags+=./tags;/


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

" vim-bookmarks colors
highlight BookmarkSign ctermbg=237 ctermfg=79
highlight BookmarkLine ctermbg=237 ctermfg=79
highlight BookmarkAnnotationSign ctermbg=237 ctermfg=79
highlight BookmarkAnnotationLine ctermbg=237 ctermfg=79

" git merge markers highlight
match WildMenu '\v^(\<|\=|\>){7}([^=].+)?$'


" Disable screen flashing on error
set vb t_vb=""




"
" Generic mappings, autocommands and commands
"


" Make vim understand numpad escape sequences
:inoremap <Esc>Oq 1
:inoremap <Esc>Or 2
:inoremap <Esc>Os 3
:inoremap <Esc>Ot 4
:inoremap <Esc>Ou 5
:inoremap <Esc>Ov 6
:inoremap <Esc>Ow 7
:inoremap <Esc>Ox 8
:inoremap <Esc>Oy 9
:inoremap <Esc>Op 0
:inoremap <Esc>On .
:inoremap <Esc>OQ /
:inoremap <Esc>OR *
:inoremap <Esc>Ol +
:inoremap <Esc>OS -
:inoremap <Esc>OM <Enter>


" split resize remappings
nmap <F9>  :resize -3<CR>
nmap <F10> :resize +3<CR>
nmap <F11> :vertical resize -3<CR>
nmap <F12> :vertical resize +3<CR>


" Split navigation: C-<x> instead of C-W C-<x>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Re-select visual block after indenting
vnoremap < <gv
vnoremap > >gv


" Search results are always centered
nnoremap n nzz
nnoremap N Nzz


" Navigate git merge markers with ]c and [c
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>


" Auto-source .vimrc on saving, update ui
function! RefreshUI()
  if exists(':AirlineRefresh')
    AirlineRefresh
  else
    " Clear & redraw the screen, then redraw all statuslines.
    redraw!
    redrawstatus!
  endif
endfunction
autocmd! bufwritepost $MYVIMRC,.vimrc source $MYVIMRC | :call RefreshUI()


" I like to hold Shift for a bit longer than necessary
command! W :w
command! Q :q
command! Wq :wq
command! WQ :wq


" :wd - save and delete the buffer (and refresh tagline, see below)
command! Wbd :w | :bd | call airline#extensions#tabline#buflist#invalidate()
cnoreabbrev wd Wbd


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

command! Fmt :call DoFmt()


" toggle space chars visibility
function! DoToggleSpaceChars()
  set list!
  set number!
endfunction

command! ToggleSpaceChars :call DoToggleSpaceChars()
nmap <F6> :ToggleSpaceChars<CR>


" Convert buffer to hex / read buffer from xxd hex dump
command! ToHex :%!xxd
command! FromHex %s#^[^:]*: \(\%(\x\+ \)\+\) .*#\1# | %!xxd -r -p


" close all buffers but this
command! O %bd | e#


" list all highlight groups
command! Hi :so $VIMRUNTIME/syntax/hitest.vim




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


" vim-lsp
let g:lsp_auto_enable = 1

nmap ;; :LspDefinition<CR>
nmap ;' :LspReferences<CR>
nmap ;l :LspHover<CR>

function! GetLspStatusMessage()
    "return lsp#get_server_status()
    return ""
endfunction


" ale
let g:ale_linters = {
    \ 'cpp': ['clang'],
    \ 'python': ['flake8', 'pylint']
\ }
let g:ale_python_pylint_options="-d C0111" " suppress missing doscstring warnings

let g:ale_completion_enabled = 1
let g:ale_open_list = 0

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0

augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

let g:my_linter_running = 0
function! GetLintingMessage()
    return g:my_linter_running ? "[linting...]" : "[idle]"
endfunction

augroup ALEProgress
    autocmd!
    autocmd User ALELintPre let g:ale_cpp_clang_options = g:my_cpp_linter_flags | let g:my_linter_running = 1 | redrawstatus
    autocmd User ALELintPost let g:my_linter_running = 0 | let g:ale_open_list = 0 | redrawstatus
augroup end

function! DoCheckSyntax()
    let g:ale_open_list = 1
    execute 'ALELint'
endfunction
nmap <F5> :call DoCheckSyntax()<CR>

command! C :ALEReset | :lcl
command! D :ALEDetail


" vim-airline, buffer tab selection remappings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

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

" https://github.com/vim-airline/vim-airline/issues/399
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

function! AirlineInit()
    call airline#parts#define_function('lint-status', 'GetLintingMessage')
    call airline#parts#define_function('lsp-status', 'GetLspStatusMessage')
    let g:airline_section_x = airline#section#create(['tagbar', ' | ', 'filetype', ' ', 'lint-status', ' ', 'lsp-status'])
  endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline_theme='bubblegum'


" rename
cnoreabbrev rn Rename


" tagbar
let g:tagbar_autofocus = 1
nmap <F8> :TagbarToggle<CR>


" nerdtree
nmap <F7> :NERDTreeToggle<CR>


" fzf.vim
function! LocalTags()
    let old_tags=&tags
    set tags=./tags;/
    execute ':Tags'
    let &tags=old_tags
endfunction

" open fzf when vim opened on a folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'Files' argv()[0] | endif

nmap [p :Files<CR> " files in working dir
nmap ]p :exe('Files ' . expand('%:p:h'))<CR> " files in directory of current file

nmap [o :call LocalTags()<CR> " tags in working dir
nmap ]o :BTags<CR> " tags in this buffer
nmap ][o :Tags<CR> " all tags



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




"
" Language-specific plugins and tweaks
"


" [C++] vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


" [C++] load cpp flags to variable for linting
let g:my_cpp_linter_flags = ""
function! GetCppFlagsFromClangDb(init_flags)
    let jq = printf("jq '.[] | select(.file | contains(\"%s\"))' ./compile_commands.json | jq -s '.[0]? | .arguments[]?'", expand('%'))

    let flags = a:init_flags
    for clangdb_file in findfile('compile_commands.json', '.;', -1)
        if !filereadable(clangdb_file)
            continue
        endif
        let entry = system(jq)
        let flags += filter(split(substitute(entry, '\"', '', 'g'), '\n'), {idx, val -> val[0] == '-' && val != '-o'})
    endfor
    return flags
endfunction

function! GetCppFlagsFromClangFile(init_flags)
    let flags = a:init_flags
    for clang_file in findfile('.clang', '.;', -1)
        if !filereadable(clang_file)
            continue
        endif
        let filtered = readfile(clang_file)
        call filter(filtered, {idx, val -> val[0] == '-'})
        let flags += filtered
    endfor
    return flags
endfunction

function! LoadCppFlags()
    let flags = ['-Wno-unknown-warning-option', '-Qunused-arguments']
    let flags += GetCppFlagsFromClangDb(flags)
    if len (flags) == 0
        let flags += ['-std=c++14', '-Wall']
        let flags += GetCppFlagsFromClangFile(flags)
    endif
    let g:my_cpp_linter_flags = join(flags, ' ')
endfunction

:autocmd FileType cpp call LoadCppFlags()


" [C++] start clangd (via vim-lsp plugin)
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif


" [C++] start cquery (via vim-lsp, if clangd is unavailble)
function! SetupCquery()
    if !executable('clangd') && executable('cquery')
        if !exists("g:my_cpp_cquery_cache_dir")
            echo "WARN: cpp cquery cache dir is not set, defaulting to profile's tmp"
            let g:my_cpp_cquery_cache_dir = "~/tmp/cquery-cache"
        endif

        au User lsp_setup call lsp#register_server({
            \ 'name': 'cquery',
            \ 'cmd': {server_info->['cquery']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            \ 'initialization_options': { 'cacheDirectory': expand(g:my_cpp_cquery_cache_dir) },
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ })
    endif
endfunction
au User LocalVimRCPost call SetupCquery()


" vim-lsp and asyncomplete.vim debugging
let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/lsp-vim.log')
"let g:asyncomplete_log_file = expand('~/lsp-asyncomplete.log')

" [Rust] start RLS (via vim-lsp plugin)
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" [python] start python language server (via vim-lsp)
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:false}}}},
        \ })
endif
