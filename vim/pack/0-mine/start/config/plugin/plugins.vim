" localvimrc
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_name = ["~/.lvimrc"]
let g:localvimrc_event = ["VimEnter"]


" asyncomplete.vim
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_min_chars = 1

" force show completion popup
imap <C-Space> <Plug>(asyncomplete_force_refresh)

" Better accept completion item mappings, close preview after completion
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" completion source: asyncomplete-buffer.vim
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'priority': 0,
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

" completion source: asyncomplete-file.vim
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))


" vim-lsp
let g:lsp_auto_enable = 1
let g:lsp_diagnostics_enabled = 0
let g:lsp_hightlight_references_enabled = 1

nmap ;; :LspDefinition<CR>
nmap ;' :LspReferences<CR>
nmap ;l :LspHover<CR>

let g:my_lsp_catalog = {}

function! GetLspStatusMessage()
    if has_key(g:my_lsp_catalog, &ft)
        let server = g:my_lsp_catalog[&ft]
        let status = lsp#get_server_status(server)
        return status == "unknown" ? "no lsp" :  server . ": " . status
    else
        return "no lsp"
    endif
endfunction

command! LspDisable if has_key(g:my_lsp_catalog, &ft) | call lsp#stop_server(g:my_lsp_catalog[&ft]) | endif

function! ToggleCompletion()
    if g:asyncomplete_auto_popup == 1
        let g:asyncomplete_auto_popup = 0
        call lsp#disable()
        echo 'Autocompletion and LSP are disabled (but <C-Space> still works)'
    else
        let g:asyncomplete_auto_popup = 1
        call lsp#enable()
        echo 'Autocompletion and LSP are enabled'
    endif
endfunction

nmap <F7> :call ToggleCompletion()<CR>


" ale
let g:ale_linters = {}

" https://github.com/w0rp/ale/issues/1176
let g:ale_cache_executable_check_failures = 1

let g:ale_completion_enabled = 1
let g:ale_open_list = 0

let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '    > '

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 0


augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

if !exists("my_global_ale_au_loaded")
    let my_global_ale_au_loaded = 1
    augroup ALEProgress
        autocmd User ALELintPre redrawstatus
        autocmd User ALELintPost let g:ale_open_list = 0 | redrawstatus
    augroup end
endif

function! AleAddLinter(lang, name)
    let current = get(g:ale_linters, a:lang, [])
    let matching = filter(copy(current), "v:val == a:name")
    if empty(matching)
        call add(current, a:name)
        let g:ale_linters = {a:lang: current}
    endif
endfunction

function! AleRemoveLinter(lang, name)
    let current = get(g:ale_linters, a:lang, [])
    let without = filter(copy(current), "v:val != a:name")
    let g:ale_linters = {a:lang: without}
endfunction

command! LL echo g:ale_linters
command! -nargs=1 AL call AleAddLinter(&filetype, <f-args>)
command! -nargs=1 DL call AleRemoveLinter(&filetype, <f-args>)

command! C :ALEReset | :lcl | :pcl
command! D :ALEDetail

nmap ,, :ALEPrevious<CR>
nmap .. :ALENext<CR>


" sneak
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1 " use ignorecase/smartcase


" git-gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" vim-airline, buffer tab selection remappings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

" https://github.com/vim-airline/vim-airline/issues/399
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

function! AirlineInit()
    call airline#parts#define_function('lsp-status', 'GetLspStatusMessage')
    let g:airline_section_x = airline#section#create(['tagbar', ' | ', 'filetype', ' [', 'lsp-status', ']'])
  endfunction
autocmd User AirlineAfterInit call AirlineInit()

" match vim-airline colors to main color theme
let g:airline_theme='nord'


" rename (rename current file)
cnoreabbrev rn Rename


" tagbar
let g:tagbar_autofocus = 1
nmap <F8> :TagbarToggle<CR>

" Tagbar doesn't recognize rust tags generated by universal-ctags
" Ignore https://github.com/rust-lang/rust.vim/blob/master/ctags/rust.ctags
" See https://github.com/rust-lang/rust.vim/issues/313
let g:rust_use_custom_ctags_defs = 1
if !exists('g:tagbar_type_rust')
   let g:tagbar_type_rust = {
       \ 'ctagstype' : 'rust',
       \ 'kinds' : [ "https://github.com/universal-ctags/ctags/blob/master/parsers/rust.c#L50-L61",
         \'M:macro,Macro Definition',
         \'P:method,A method',
         \'c:implementation,implementation',
         \'e:enumerator,An enum variant',
         \'f:function,Function',
         \'g:enum,Enum',
         \'i:interface,trait interface',
         \'m:field,A struct field',
         \'n:module,module',
         \'s:struct,structural type',
         \'t:typedef,Type Alias',
         \'v:variable,Global variable',
       \ ]
   \ }
endif


" fzf.vim
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~55%' }

" [WIP] Fzf-ify vim-lsp's quickfix contents
function! s:format_error(item) abort
  return (a:item.bufnr ? bufname(a:item.bufnr) : '')
        \ . '|' . (a:item.lnum  ? a:item.lnum : '')
        \ . (a:item.col ? ' col ' . a:item.col : '')
        \ . '|' . substitute(a:item.text, '\v^\s*', ' ', '')
endfunction

function! s:handle_symbol_line(symb)
    echo a:symv[0]
endfunction

function! Sy()
    "let opts = fzf#vim#with_preview()
    "echom opts
    let l:opts = {
        \ 'source': map(getqflist(), {k, val -> s:format_error(val)}),
        \ 'sink': function('s:handle_symbol_line'),
        \ 'options': ' --prompt="Symbol> "'
        \ }
    call fzf#run(fzf#wrap(l:opts))
endfunction
"au! BufReadPost quickfix :call LspDocSymbols()<CR>

" Make sure <Esc> in fzf does not get overwritten with custom mapping
function! s:FzfEscMap()
    let g:my_tesc_mapping = maparg('<Esc>', 't')
    tmap <Esc> <C-d>
endfunction

function! s:FzfEscUnmap()
    if exists('g:my_tesc_mapping')
        exe 'tmap <Esc> ' . g:my_tesc_mapping
    endif
endfunction

augroup FzfEscPushPop
    au! FileType fzf
    au FileType fzf call s:FzfEscMap()
        \| au BufLeave <buffer> call s:FzfEscUnmap()
augroup END

" files in working dir
nmap [p :Files!<CR>
" files in directory of current file
nmap ]p :exe('Files! ' . expand('%:p:h'))<CR>
" files in home dir
nmap ][p :Files! ~<CR>

" Fzf-search word under cursor
nmap <F2> "zyiw:exe ":Rg ".@z.""<CR>
" Fullscreen short :Files command
command! -nargs=1 -complete=file F :Files! <args>
" close all buffers, open file picker
command! Z %bd | :Files!

" override :Rg, :Files to display preview
command! -bang -nargs=* Rg call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>1)

cnoreabbrev Ag Rg
cnoreabbrev rg Rg

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>,
  \ fzf#vim#with_preview('right:60%', '?'), <bang>0)

" match fzf colors to main color theme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }


" vim-bookmarks
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_save_per_working_dir = 0
let g:bookmark_manage_per_buffer = 0
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_show_toggle_warning = 0
let g:bookmark_center = 1

let g:bookmark_disable_ctrlp = 1 " or ma in ctrlp list (not sorted!)
let g:bookmark_location_list = 0 " quickfix or location list

nmap ml <Plug>BookmarkShowAll


" matchit (% jumps tags for html/xml-like filetypes)
runtime macros/matchit.vim

" vim-lsp and asyncomplete.vim debugging (uncomment to enable logging)
let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/lsp-vim.log')
"let g:asyncomplete_log_file = expand('~/lsp-asyncomplete.log')
