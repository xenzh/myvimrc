" ale
let g:ale_linters = {}

" https://github.com/w0rp/ale/issues/1176
let g:ale_cache_executable_check_failures = 1

let g:ale_completion_enabled = has('nvim') ? 0 : 1
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
command! D :ALEDetai

nnoremap <leader>c :C<CR>
nnoremap <leader>d :D<CR>

nmap ,, :ALEPrevious<CR>
nmap .. :ALENext<CR>


" git-gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" a.vim
command! AVV :AV | wincmd R


" vista.vim
let g:vista_default_executive = 'nvim_lsp'
let g:vista_finder_alternative_executives = ['ale']
let g:vista_sidebar_width = 80
let g:vista_fzf_preview = ['right:0%']

let g:vista#renderer#enable_icon = 0
let g:vista#renderer#enable_kind = 0

nmap <F8> :Vista!!<CR>
nmap \ :Vista finder<CR>


" nvim-treesitter, nvim-treesitter-textobject
if has('nvim') && exists('TSModuleInfo')
lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "python", "rust", "lua", "vim", "markdown", "markdown_inline", "toml", "yaml"},
    sync_install = true,

    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gbb",
            scope_incremental = "gbn",
            node_decremental = "gbv",
            node_incremental = "gbh",
        },
    },

    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
            -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
            },
            -- these do not really work (yet?)
            swap_next = {
                ["m."] = "@parameter.inner",
            },
            swap_previous = {
                ["m,"] = "@parameter.inner",
            },
            goto_next_start = {
                ["]o"] = "@parameter.inner",
            },
            goto_previous_start = {
                ["[o"] = "@parameter.inner",
            },
        },
    },
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

endif


" oil.nvim
if has('nvim')
lua << EOF
require("oil").setup()
vim.keymap.set('n', '-', '<CMD>Oil<CR>')
EOF
endif


" vim-airline, buffer tab selection remappings
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ':'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'


nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
"nmap <leader>< <Plug>AirlineSelectPrevTab
"nmap <leader>> <Plug>AirlineSelectNextTab

" https://github.com/vim-airline/vim-airline/issues/399
autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

function! GetLspStatusMessage()
      if !has('nvim') || !luaeval('#vim.lsp.get_clients({bufnr = 0}) > 0')
          return 'no lsp'
      endif
      let names = luaeval('vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({bufnr = 0}))')
      return join(names, ', ') .. ': running'
  endfunction


function! GetNearestFunction() abort
    if has('nvim') && exists(':TSModuleInfo')
        let s:symbol = nvim_treesitter#statusline()
        if !empty(s:symbol)
            return s:symbol
        endif
    endif
    return ""
endfunction

function! AirlineInit()
    call airline#parts#define_text('separator', "  \ue0b3 ")
    call airline#parts#define_accent('nearest', 'bold')

    call airline#parts#define_function('lsp', 'GetLspStatusMessage')

    call airline#parts#define_function('nearest', 'GetNearestFunction')
    call airline#parts#define_accent('nearest', 'cyan')

    let g:airline_section_x = airline#section#create(['nearest', 'separator', 'filetype', 'separator', 'lsp'])
endfunction

autocmd User AirlineAfterInit call AirlineInit()

" match vim-airline colors to main color theme
let g:airline_theme='nord'


