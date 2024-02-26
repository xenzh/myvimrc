" Do not reload this script
" Oterwise filetype autocmd will try to reload functions being executed
" after "setf json" call in DoJqQuery()
if exists('*DoJqQuery')
    finish
endif


set tabstop=2
set shiftwidth=2
set foldmethod=syntax
set nospell


" formatting
function! DoFmt()
    setf json
    if executable('jq')
      %!jq .
    elseif executable('python')
      %!python -m json.tool
      %s/\s\s/ /g " replace indent, 4 spaces -> 2 spaces
    else
      echo 'Unable to format: jq and python executables cannot be found'
    endif
endfunction


" Interactive jq shell
function! DoJqQuery(query, json_bufnr, result_bufnr)
    let json_bufwinnr = bufwinnr(a:json_bufnr)
    let result_bufwinnr = bufwinnr(a:result_bufnr)
    let returnto_bufwinnr = bufwinnr('%')

    " 1. Go to json buffer, call jq
    execute json_bufwinnr . 'wincmd w'
    let shell_cmd = "jq '" . a:query . "'"
    let result = system(shell_cmd, join(getline(1, '$')))

    " 2. Go to result buffer, post output
    execute result_bufwinnr . 'wincmd w'
    execute ':1,$d'
    let @a = result
    normal! G
    execute 'put a'
    if v:shell_error == 0
        silent call DoFmt()
    endif

    " 3. Go back to original buffer
    execute returnto_bufwinnr . 'wincmd w'
endfunction

function! StartJqSession()
    " 1. this buffer is json buffer, and the only one opened
    execute '%bd | e#'
    let s:json_bufnr = bufnr('%')

    " 2. create query buffer
    execute ':sil! bdel! ' . bufwinnr(s:query_bufnr)
    below 2new
    let @a = "# Write your jq query on the following line. Save&Quit: <CR>, Cancel: <Esc>\n."
    normal! gg
    execute 'put! a'
    let s:query_bufnr = bufnr('%')

    " Normal mode, query window: <CR> - close query and jump to result; Esc - close query and result
    command! -buffer Apply :execute 'sil! bd! ' . s:query_bufnr | :execute bufwinnr(s:result_bufnr) . 'wincmd w'
    nnoremap <buffer> <CR> :Apply<CR>
    command! -buffer Cancel :execute ':bd! ' . s:result_bufnr | :execute 'sil! bd! ' . s:query_bufnr
    nnoremap <buffer> <Esc> :Cancel<CR>

    autocmd! TextChangedI <buffer> :call DoJqQuery(getline(2), s:json_bufnr, s:result_bufnr)

    " 3. create results buffer
    silent execute ':sil! bd! ' . s:result_bufnr
    execute bufwinnr(s:json_bufnr) . 'wincmd w'
    below vnew
    let s:result_bufnr = bufnr('%')

    " 4 get ready for input
    execute bufwinnr(s:query_bufnr) . 'wincmd w'
    startinsert! " startappend
endfunction

let s:query_bufnr = -1
let s:result_bufnr = -1

command! Jq :call StartJqSession()
