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
