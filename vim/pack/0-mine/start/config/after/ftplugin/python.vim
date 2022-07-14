set cc=120

" ale
if !exists('g:ale_linters')
    let g:ale_linters = {}
endif
let g:ale_linters.python = ['pylint', 'black', 'flake8', 'mypy']

if !exists('g:ale_fixers')
    let g:ale_fixers = {}
endif
let g:ale_fixers.python = ['black']

let g:ale_python_pylint_options="-d C0111,C0330" " suppress missing doscstring warnings and black indentation
"let g:ale_python_flake8_options="--ignore=E501" " suppress black indentation
let g:ale_python_mypy_options="--strict --warn-unreachable"


" formatting
function! DoFmt()
    execute ':ALEFix black'
endfunction


" start python language server (via vim-lsp)
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:false}}}},
        \ })

    let g:my_lsp_catalog = { 'python': 'pyls' }
endif
