"
" MY Vimrc, one and only
"
"
" Plugins and binaries used:
" * pathogen (plugin manager)
"   https://github.com/tpope/vim-pathogen
"
" * a.vim (:A to switch between h/cpp)
"   https://github.com/vim-scripts/a.vim
"
" * clang.vim [+ clang binary] (per-file C++ error check on save, autocompletion)
"   https://github.com/justmao945/vim-clang
"
" * cscope.vim [+ cscope binary] (C code navigation: caller/callee, etc. Has issues with C++)
"   [test it, should work w/o the plugin!]
"
" * nerdcommenter (block comment/uncomment)
"   https://github.com/scrooloose/nerdcommenter
"
" * nerdtree (side pane, fs navigation)
"   https://github.com/Xuyuanp/nerdtree-git-plugin
"
" * tagbar [+ctags binary] (side pane, code outline)
"   https://github.com/majutsushi/tagbar
"
" * vim-airline (status bar and buffers bar)
"   https://github.com/vim-airline/vim-airline
"
" * vim-cpp-enhanced-highlight
"   https://github.com/octol/vim-cpp-enhanced-highlight
"
" * fugitive [+ git binary] (git integration)
"   https://github.com/tpope/vim-fugitive
"
"
" Third-party tools:
" * ctags
" * cscope
" * clang
"
" Generated files:
" * .clang - simple file with -I compiler flags, clang.vim uses it to locate headers
" * tags - ctags output file, used for code navigation
" * cscope.out - cscope output, used for code navigation
"
" codenav.sh (generates ctags and cscope output):
" #!/bin/ksh
" codeDir=${1:-$PWD}
" cd /
" find $codeDir -name '*.cc' \
"     -o -name '*.h' \
"     -o -name '*.cpp' \
"     -o -name '*.c' > $codeDir/cscope.files
" cd $codeDir && cscope -b -q
" export CSCOPE_DB=$codeDir/cscope.out
" ctags -R .
"
" You might want to update .Xdefaults/.Xresources for better experience of
" using vim in xterm


"
" Basic config
"


" use utf-8 everywhere
scriptencoding utf-8
set encoding=utf-8


" use per-directory .vimrc-s
set exrc
set secure


" color scheme
set term=xterm-256color
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


" syntax
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


" special chars
set list
set listchars=tab:→→,trail:·,space:·


" split resize remappings
nmap <F9>  :resize -3<CR>
nmap <F10> :resize +3<CR>
nmap <F11> :vertical resize -3<CR>
nmap <F12> :vertical resize +3<CR>




"
" Common plugins config
"


" pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on


" ctags and cscope
set tags=./tags;/

if has("scope")

  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/srci

  function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
    endif
  endfunction
  au BufEnter /* call LoadCscope()

endif


" vim-airline, plus buffer tab select remappins
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

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




"
" C++ plugins config
"


" vim-clang
let g:clang_auto = 0
let g:clang_c_completeopt = 'menuone,preview'
let g:clang_cpp_completeopt = 'menuone,preview'
let g:clang_include_sysheaders = 1
let g:clang_cpp_options = '-std=c++14'
let g:clang_syntax_check_auto = 0

function! DoClangCheckSyntax()
  set cmdheight=2
  echo "Clang syntax check running..."
  ClangSyntaxCheck
  echo "done!"
  set cmdheight=1
endfunction
nmap <F5> :call DoClangCheckSyntax()<CR>



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


