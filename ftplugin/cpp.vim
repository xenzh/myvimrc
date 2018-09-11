" ale
let g:ale_linters.cpp = ['clang']

if !exists('my_cpp_ale_au_loaded')
    let my_cpp_ale_au_loaded = 1
    augroup ALEProgress
        autocmd User ALELintPre let g:ale_cpp_clang_options = g:my_cpp_linter_flags
    augroup end
endif


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1


" load cpp flags to variable for linting
let g:my_cpp_linter_flags = ""
function! GetCppFlagsFromClangDb(init_flags)
    " clang db does not include info for headers, try to get it from matching cpp or bail out
    let thisfile = expand('%')
    if expand('%:e') == 'h' && filereadable(expand('%:r') . '.cpp')
        let thisfile = expand('%:r') . '.cpp'
    endif
    let jq = printf("jq '.[] | select(.file | contains(\"%s\"))' ./compile_commands.json | jq -s '.[0]? | .arguments[]?'", thisfile)

    let flags = a:init_flags
    for clangdb_file in findfile('compile_commands.json', '.;', -1)
        if !filereadable(clangdb_file)
            continue
        endif
        let entry = system(jq)
        let flags += filter(split(substitute(entry, '\"', '', 'g'), '\n'), {idx, val -> val[0] == '-' && val != '-o'})
    endfor
    return flags
endfunction

function! GetCppFlagsFromClangFile(init_flags)
    let flags = a:init_flags
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
    let flags = ['-Wno-unknown-warning-option', '-Qunused-arguments']
    let flags = GetCppFlagsFromClangDb(flags)
    if len (flags) == 2
        let flags += ['-std=c++14', '-Wall']
        let flags = GetCppFlagsFromClangFile(flags)
    endif
    let g:my_cpp_linter_flags = join(flags, ' ')
endfunction

call LoadCppFlags()


" start clangd (via vim-lsp plugin)
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })

    let g:my_lsp_catalog.cpp = 'clangd'
endif


" start cquery (via vim-lsp, if clangd is unavailble)
function! SetupCquery()
    if !executable('clangd') && executable('cquery')
        if !exists("g:my_cpp_cquery_cache_dir")
            echo "WARN: cpp cquery cache dir is not set, defaulting to profile's tmp"
            let g:my_cpp_cquery_cache_dir = "~/tmp/cquery-cache"
        endif

        au User lsp_setup call lsp#register_server({
            \ 'name': 'cquery',
            \ 'cmd': {server_info->['cquery']},
            \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
            \ 'initialization_options': { 'cacheDirectory': expand(g:my_cpp_cquery_cache_dir) },
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
            \ })

        let g:my_lsp_catalog.cpp = 'cquery'
    endif
endfunction

au User LocalVimRCPost call SetupCquery()
