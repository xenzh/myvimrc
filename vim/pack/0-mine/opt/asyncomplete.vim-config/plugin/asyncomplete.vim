" asyncomplete.vim
let g:asyncomplete_smart_completion = 0 " you need lua for this
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1

" force show completion popup
imap <C-Space> <Plug>(asyncomplete_force_refresh)

