set cc=120

" ale
let g:ale_linters.cpp = ['cc', 'clangtidy']

"let g:ale_c_build_dir_names = ['.']
" this one is super broken for -isystem, see ale_linters#cpp#cc#GetCommand() and ale#c#GetCFlags()
let g:ale_c_parse_compile_commands = 0

let g:my_cpp_linter_flags = []
let g:my_cpp_linter_default_flags = ['-std=c++17']
let g:my_cpp_linter_extra_flags = ['-Wno-unknown-warning-option', '-Wno-infinite-recursion', '-Wall']

function! SetAleClangOptions()
    let g:ale_cpp_cc_options = join(g:my_cpp_linter_flags, ' ')
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
    " clang db only includes entries for *.cpp files, so for headers:
    " * try locating matching *.cpp file;
    " * try using any *.cpp from the same folder;
    " * try using any *.cpp file from compilation database.
    let forfile = expand('%')
    if expand('%:e') == 'h'
        if filereadable(expand('%:r') . '.cpp')
            let forfile = expand('%:r') . '.cpp'
        else
            let samedir = split(globpath(fnamemodify(forfile, ':p:h'), '*.cpp'), '\n')
            if (len(samedir) > 0)
                let forfile = samedir[0]
            else
                let forfile = '.cpp'
            endif
        endif
    endif

    let jq_fmt = "jq '.[] | select(.file | contains(\"%s\"))' %s | jq -s '.[0]? | .arguments[]?, (.command? | split(\" \") | .[])'"

    let flags = []
    for clangdb_file in findfile('compile_commands.json', '**1', -1)
        if !filereadable(clangdb_file)
            continue
        endif

        let clangdb_dir = fnamemodify(clangdb_file, ':p:h')

        " Find file entry, parse .arguments or .commands key as newline separated list
        let result = system(printf(jq_fmt, forfile, clangdb_file))
        if v:shell_error != 0
            let result = system(printf(jq_fmt, '.cpp', clangdb_file))
        endif
        let arguments = split(substitute(result, '\"', '', 'g'), '\n')

        " Filter and transform argument list:
        " * Ignore flags aside from -I, -isystem and -std
        " * For -isystem, format two list elements into a single path.
        " * If include path are relative, add clangdb_dir to them.
        let item = 0
        let includes = []
        while(item < len(arguments))
            if arguments[item][0:1] ==# '-I'
                let iflag = arguments[item]
                if iflag[2] != '/'
                    let iflag = '-I' . clangdb_dir . '/' . iflag[2:]
                endif
                call add(includes, iflag)
            elseif arguments[item][0:len('-isystem') - 1] ==# '-isystem'
                let path = arguments[item + 1]
                if path[0] != '/'
                    let path = clangdb_dir . '/' . path
                endif
                call add(includes, arguments[item] . ' ' . path)
                let item += 1
            elseif arguments[item][0:len('-std=') - 1] ==# '-std='
                call add(includes, arguments[item])
            endif
            let item += 1
        endwhile

        if len(includes) > 0
            echom printf('Loaded C++ flags from "%s" for "%s"', clangdb_file, forfile)
        endif
        let flags += includes
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
