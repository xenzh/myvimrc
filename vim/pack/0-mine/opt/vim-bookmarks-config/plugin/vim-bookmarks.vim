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
