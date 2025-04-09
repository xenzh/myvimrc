" ale
if !exists('g:ale_linters')
    let g:ale_linters = {}
endif
let g:ale_linters.rust = ['analyzer', 'rustfmt', 'cargo']

let g:ale_rust_analyzer_config = {
\  'cargo': {
\    'features': 'all',
\  }
\}

if !exists('g:ale_fixers')
    let g:ale_fixers = {}
endif
let g:ale_fixers.rust = ['rustfmt']

let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
let g:ale_rust_cargo_check_tests = 1
let g:ale_rust_cargo_check_all_targets = 1
let g:ale_rust_rustfmt_options = '--edition 2024'


" formatting
function! DoFmt()
    execute ':ALEFix rustfmt'
endfunction


" start RLS (via vim-lsp plugin)
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rust-analyzer']},
        \ 'whitelist': ['rust'],
        \   'initialization_options': {
        \     'cargo': {
        \       'buildScripts': {
        \         'enable': v:true,
        \       },
        \       'features': 'all'
        \     },
        \     'procMacro': {
        \       'enable': v:true,
        \     },
        \   },
        \ })

    if !exists('g:my_lsp_catalog')
        let g:my_lsp_catalog = {}
    endif
    let g:my_lsp_catalog.rust = 'rls'
endif
