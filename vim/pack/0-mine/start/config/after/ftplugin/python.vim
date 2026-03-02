set cc=120

" ale
if !exists('g:ale_linters')
    let g:ale_linters = {}
endif
let g:ale_linters.python = ['black', 'ruff', 'mypy']

if !exists('g:ale_fixers')
    let g:ale_fixers = {}
endif
let g:ale_fixers.python = ['black']

"let g:ale_python_flake8_options="--ignore=E501" " suppress black indentation
let g:ale_python_mypy_options="--strict --warn-unreachable"


" formatting
function! DoFmt()
    execute ':ALEFix black'
endfunction
