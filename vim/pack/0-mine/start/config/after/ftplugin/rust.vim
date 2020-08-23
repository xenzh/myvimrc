let g:ale_linters.rust = ['cargo', 'rustfmt']
let g:ale_fixers.rust = ['rustfmt']

let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_all_targets = 1


" formatting
function! DoFmt()
    execute ':ALEFix rustfmt'
endfunction


" start RLS (via vim-lsp plugin)
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })

    let g:my_lsp_catalog.rust = 'rls'
endif
