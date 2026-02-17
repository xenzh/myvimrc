" ale
if !exists('g:ale_linters')
    let g:ale_linters = {}
endif
" Diagnostics handled by rust-analyzer (clippy configured in lsp.lua)
let g:ale_linters.rust = []

" formatting via LSP (rust-analyzer -> rustfmt)
function! DoFmt()
    lua vim.lsp.buf.format({ async = true })
endfunction


" start RLS (via vim-lsp plugin)
"if executable('rust-analyzer')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'rls',
"        \ 'cmd': {server_info->['rust-analyzer']},
"        \ 'whitelist': ['rust'],
"        \   'initialization_options': {
"        \     'cargo': {
"        \       'buildScripts': {
"        \         'enable': v:true,
"        \       },
"        \       'features': 'all'
"        \     },
"        \     'procMacro': {
"        \       'enable': v:true,
"        \     },
"        \   },
"        \ })

"    if !exists('g:my_lsp_catalog')
"        let g:my_lsp_catalog = {}
"    endif
"    let g:my_lsp_catalog.rust = 'rls'
"endif
