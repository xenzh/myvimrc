set cc=120

" ale
let g:ale_linters.cpp = ['clang', 'clangtidy']

let g:my_cpp_linter_flags = []
let g:my_cpp_linter_default_flags = ['-std=c++17']
let g:my_cpp_linter_extra_flags = ['-Wno-unknown-warning-option', '-Wno-infinite-recursion', '-Wall']

function! SetAleClangOptions()
    let g:ale_cpp_clang_options = join(g:my_cpp_linter_flags, ' ')
endfunction

function! SetAleClangTidyOptions()
    let g:ale_cpp_clangtidy_options = join(g:my_cpp_linter_flags, ' ')
    let g:ale_cpp_clangtidy_extra_options = join(g:my_cpp_linter_default_flags, ' ')
endfunction

if !exists('my_cpp_ale_au_loaded')
    let my_cpp_ale_au_loaded = 1
    augroup ALEProgress
        autocmd User ALELintPre call SetAleClangOptions()
        autocmd User ALELintPre call SetAleClangTidyOptions()
    augroup end
endif


function! GetCppFlagsFromClangDb()
    " clang db does not include info for headers, try to get it from matching cpp or bail out
    let thisfile = expand('%')
    if expand('%:e') == 'h' && filereadable(expand('%:r') . '.cpp')
        let thisfile = expand('%:r') . '.cpp'
    endif
    let jq = printf("jq '.[] | select(.file | contains(\"%s\"))' ./compile_commands.json | jq -s '.[0]? | .arguments[]?'", thisfile)

    let flags = []
    for clangdb_file in findfile('compile_commands.json', '.;', -1)
        if !filereadable(clangdb_file)
            continue
        endif
        let entry = system(jq)
        let flags += filter(split(substitute(entry, '\"', '', 'g'), '\n'), {idx, val -> val[0] == '-' && val != '-o'})
    endfor
    return flags
endfunction

function! GetCppFlagsFromClangFile()
    let flags = []
    for clang_file in findfile('.clang', '.;', -1)
        if !filereadable(clang_file)
            continue
        endif
        let filtered = readfile(clang_file)
        call filter(filtered, {idx, val -> val[0] == '-'})
        let flags += filtered
    endfor
    return flags
endfunction

function! LoadCppFlags()
    let flags = GetCppFlagsFromClangDb()
    if len (flags) == 0
        let flags = GetCppFlagsFromClangFile()
        let flags += g:my_cpp_linter_default_flags
    endif
    let flags += g:my_cpp_linter_extra_flags
    let g:my_cpp_linter_flags = flags
endfunction

call LoadCppFlags()


" start clangd (via vim-lsp plugin)
if executable('clangd')
    let clangd_version = matchlist(system('clangd -version'), '^clangd version \(\d\+\)')

    let Cmd = {server_info->['clangd']}
    if len(clangd_version) > 1 && clangd_version[1] >= 10
        let Cmd = {servier_info->['clangd', '-background-index', '-all-scopes-completion', '-completion-style=detailed', '-header-insertion=never']}
    endif

    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': Cmd,
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })

    let g:my_lsp_catalog.cpp = 'clangd'
endif


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
