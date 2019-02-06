"
" Generic mappings, commands and autocommands
"


" leader key is space
let g:mapleader=" "


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


" autocompletion popup controls and preview autohide
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Fix <C-Space> (terminal doesn't understand <C-Space> and sends ^@ or <Nul> instead)
imap <C-@> <C-Space>


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


" Better indent: re-select visual block after each step
vnoremap < <gv
vnoremap > >gv


" Search results are always centered
nnoremap n nzz
nnoremap N Nzz


" No highlight
nnoremap <leader>l :noh<CR>


" Navigate git merge markers with ]c and [c, highlight markers
nnoremap <silent> ]c /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>
match WildMenu '\v^(\<|\=|\>){7}([^=].+)?$'


" no filetype is text filetype
au! BufEnter * if &filetype == "" | setlocal ft=text | endif


" save/load views
augroup views
    au! BufWinLeave * if expand('%') != '' && &buftype !~ 'nofile' | mkview! | endif
    au! BufWinEnter * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
augroup END


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
autocmd! bufwritepost $MYVIMRC,.vimrc nested source $MYVIMRC | :call RefreshUI()


" I like to hold Shift for a bit longer than necessary
command! W :w
command! Q :q
command! Wq :wq
command! WQ :wq


" :wd - save and delete the buffer (and refresh tagline, see below)
command! Wd :w | :bd | call airline#extensions#tabline#buflist#invalidate()
cnoreabbrev wd Wd


" close all buffers but this
command! O %bd | e#


" find selecton/repeat search, open quickfix with results (and close it on <CR>)
function! FindAndQuickfix(what)
    execute 'vimgrep "' . a:what . '" ' . expand('%') | copen
endfunction

autocmd! FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

command! -range Gr <line1>, <line2>call s:process_selection(function('FindAndQuickfix'))
command! Gre :call FindAndQuickfix(@/)


" toggle space chars visibility
function! DoToggleSpaceChars()
  set list!
  set number!
endfunction

command! ToggleSpaceChars :call DoToggleSpaceChars()
nmap <F6> :ToggleSpaceChars<CR>


" i don't care who you are, just get closed
command! AllClose :ccl | :pcl | :lcl
cnoreabbrev acl AllClose


" Convert buffer to hex / read buffer from xxd hex dump
command! ToHex :%!xxd
command! FromHex %s#^[^:]*: \(\%(\x\+ \)\+\) .*#\1# | %!xxd -r -p

" list all highlight groups
command! Hi :so $VIMRUNTIME/syntax/hitest.vim


" Big file mode
function! ToggleBigFileMode()
    set cursorline!
    set lazyredraw!
    call ToggleCompletion()
    exe 'AirlineToggle'
endfunction
nmap <leader>b :call ToggleBigFileMode()<CR>


" Code formatting
function! DoFmt()
  echo 'Formatting is not implemented for this filetype (see .vim/ftplugin)'
endfunction

command! Fmt :call DoFmt()


" Range function wrapper that reads selected text and calls a functor
" https://vi.stackexchange.com/a/11028
function! s:process_selection(fn) range
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  call a:fn(join(lines, "\n"))
endfunction


" Interpret selection as json, copy it to right split and format
function! JsonToRsplit(sel)
    below vnew
    let @a = a:sel
    normal! G
    execute 'put a'
    setf json
    call DoFmt()
endfunction

command! -range Jsp <line1>,<line2>call s:process_selection(function('JsonToRsplit'))
