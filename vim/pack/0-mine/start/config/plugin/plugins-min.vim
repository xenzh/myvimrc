" rename (rename current file)
cnoreabbrev rn Rename


" fzf.vim
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~35%' }


" Make sure <Esc> in fzf does not get overwritten with custom mapping
function! s:FzfEscMap()
    let g:my_tesc_mapping = maparg('<Esc>', 't')
    tmap <Esc> <C-d>
endfunction

function! s:FzfEscUnmap()
    if exists('g:my_tesc_mapping')
        exe 'tmap <Esc> ' . g:my_tesc_mapping
    endif
endfunction

augroup FzfEscPushPop
    au! FileType fzf
    au FileType fzf call s:FzfEscMap()
        \| au BufLeave <buffer> call s:FzfEscUnmap()
augroup END

" files in working dir
nmap [p :Files!<CR>
" files in directory of current file
nmap ]p :exe('Files! ' . expand('%:p:h'))<CR>
" files in home dir
nmap ][p :Files! ~<CR>
" opened buffers
nmap ][ :Buffers!<CR>

" Fzf-search word under cursor
nmap <F2> "zyiw:exe ":Rg ".@z.""<CR>
" Fullscreen short :Files command
command! -nargs=1 -complete=file F :Files! <args>
" close all buffers, open file picker
command! Z %bd | :Files!

" Open vsplit, search files in working dir
command! Fsp :vsp | :Files!
cnoreabbrev fsp Fsp

" override :Rg, :Files to display preview
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>1)

cnoreabbrev Ag Rg
cnoreabbrev rg Rg

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>0)


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


" matchit (% jumps tags for html/xml-like filetypes)
runtime macros/matchit.vim


