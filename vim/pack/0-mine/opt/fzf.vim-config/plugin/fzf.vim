" fzf.vim
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~55%' }

function! LocalTags()
    let old_tags=&tags
    set tags=./tags;/
    execute ':Tags!'
    let &tags=old_tags
endfunction

nmap [p :Files!<CR> " files in working dir
nmap ]p :exe('Files! ' . expand('%:p:h'))<CR> " files in directory of current file
nmap ][p :Files! ~<CR> " files in home dir

nmap [o :call LocalTags()<CR> " tags in working dir
nmap ]o :BTags!<CR> " tags in this buffer
nmap ][o :Tags!<CR> " all tags

nmap <F2> "zyiw:exe ":Rg ".@z.""<CR>

command! -nargs=1 -complete=file F :Files! <args>
command! Z %bd | :Files!

" override :Rg, :Files to display preview
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>1)

cnoreabbrev Ag Rg
cnoreabbrev rg Rg

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>0)

" match fzf colors to main color theme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

