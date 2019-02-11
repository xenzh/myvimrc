" ale
let g:ale_linters = {}

" https://github.com/w0rp/ale/issues/1176
let g:ale_cache_executable_check_failures = 1

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
    return g:my_linter_running ? "linting..." : "idle"
endfunction

if !exists("my_global_ale_au_loaded")
    let my_global_ale_au_loaded = 1
    augroup ALEProgress
        autocmd User ALELintPre let g:my_linter_running = 1 | redrawstatus
        autocmd User ALELintPost let g:my_linter_running = 0 | let g:ale_open_list = 0 | redrawstatus
    augroup end
endif

function! DoCheckSyntax()
    let g:ale_open_list = 1
    execute 'Gcd'
    execute 'ALELint'
endfunction
nmap <F5> :call DoCheckSyntax()<CR>

command! C :ALEReset | :lcl | :pcl
command! D :ALEDetail

