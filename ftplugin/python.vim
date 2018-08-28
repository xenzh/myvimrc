" ale
let g:ale_linters.python = ['pylint']
let g:ale_python_pylint_options="-d C0111" " suppress missing doscstring warnings


" start python language server (via vim-lsp)
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:false}}}},
        \ })
endif
