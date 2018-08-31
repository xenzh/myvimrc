" disable reinit when calling DoJqQuery (because it does setf json)
if exists('*DoJqQuery')
    finish
endif

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


" interactive jq wrapper
function! DoJqQuery(query, json_bufwinnr, result_bufwinnr)
    let json_bufwinnr = a:json_bufwinnr
    let result_bufwinnr = a:result_bufwinnr
    let returnto_bufwinnr = bufwinnr('%')

    " 1. Go to json buffer, call jq
    execute a:json_bufwinnr . 'wincmd w'
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

function! RunJqQuery()
    " return if query is empty, close jq buffer if there is one
    "if a:query == ""
    "    if s:jq_bufwinnr == -1 && use_same_buffer == 0
    "        execute(':bdelete ' . s:jq_bufwinnr)
    "        let s:jq_bufwinnr = -1
    "        return
    "    endif
    "    return
    "endif
endfunction

function! StartJqSession()
    " 1. this buffer is json buffer
    let json_bufnr = bufnr('%')

    " 2. create query buffer
    execute ':silent! bdelete! ' . s:query_bufwinnr
    below new
    let query_bufnr = bufnr('%')

    autocmd! TextChangedI <buffer> :call DoJqQuery(getline(1), s:json_bufwinnr, s:result_bufwinnr)
    autocmd! BufDelete <buffer> execute ':bdelete! ' . s:result_bufwinnr

    " 3. create results buffer
    silent execute ':silent! bdelete! ' . s:result_bufwinnr
    execute getwinnr(json_bufwinnr) . 'wincmd w'
    below vnew
    let result_bufnr = bufnr('%')

    let s:json_bufwinnr = getwinnr(json_bufnr)
    let s:query_bufwinnr = getwinnr(query_bufnr)
    let s:result_bufwinnr = getwinnr(result_bufnr)

    " 4 get ready for input
    execute s:query_bufwinnr . 'wincmd w'

    "echom s:json_bufwinnr
    "echom s:query_bufwinnr
    "echom s:result_bufwinnr

    startinsert
endfunction

let s:query_bufwinnr = -1
let s:result_bufwinnr = -1

"command! -nargs=1 Jq :call DoJqQuery(<f-args>, bufwinnr('%'))
"command! -nargs=1 Jqi :call DoJqQuery(<f-args>, -1)

