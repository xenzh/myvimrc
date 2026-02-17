" util: get 'which' color from 'group'
function! s:get_color(group, which)
    redir => histr
    silent execute 'silent highlight ' . a:group
    redir END

    let link_match = matchlist(histr, 'links to \(\S\+\)')
    if len(link_match) > 0
        return s:get_color(link_match[1], a:which)
    endif

    let color_match = matchlist(histr, a:which . '=\([0-9A-Za-z]\+\)')
    if len(color_match) == 0
        return 'NONE'
    endif
    return color_match[1]
endfunction

" enable italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" colorscheme and color overrides
function! OverrideColors()
    "hi Comment ctermfg=4
    "hi SpecialKey ctermfg=darkgray
    "hi TabLineSel ctermfg=darkgray

    "various italics
    hi markdownItalic cterm=italic gui=italic

    " ALE
    hi link ALEWarning SpellLocal
    hi link ALEVirtualTextError SpellCap
    hi link ALEVirtualTextStyleError SpellRare

    " LSP / floating windows
    hi NormalFloat guifg=#D8DEE9 guibg=#2E3440
    hi FloatBorder guifg=#616E88 guibg=#2E3440

    " Markdown in hover windows (Nord maps these all to Normal fg)
    hi link @markup.heading Title
    hi link @markup.heading.1 Title
    hi link @markup.heading.2 Title
    hi link @markup.raw String
    hi @markup.raw.block guifg=NONE ctermfg=NONE
    hi link @markup.link.url Underlined
    hi link @markup.link.label Special

    " nvim-cmp completion menu
    hi CmpItemAbbrMatch      gui=bold guifg=#88C0D0
    hi CmpItemAbbrMatchFuzzy gui=bold guifg=#88C0D0
    hi link CmpItemAbbrDeprecated Comment
    hi link CmpItemKindFunction   Function
    hi link CmpItemKindMethod     Function
    hi link CmpItemKindConstructor Function
    hi link CmpItemKindVariable   Identifier
    hi link CmpItemKindField      Identifier
    hi link CmpItemKindProperty   Identifier
    hi link CmpItemKindClass      Type
    hi link CmpItemKindStruct     Type
    hi link CmpItemKindInterface  Type
    hi link CmpItemKindEnum       Type
    hi link CmpItemKindModule     Include
    hi link CmpItemKindKeyword    Keyword
    hi link CmpItemKindConstant   Constant
    hi link CmpItemKindEnumMember Constant
    hi link CmpItemKindValue      Constant
    hi link CmpItemKindSnippet    Comment
    hi link CmpItemKindText       Comment
    hi link CmpItemMenu           Comment

    " vim-bookmarks
    hi link BookmarkSign StatusLine
    hi link BookmarkLine StatusLine
    hi link BookmarkAnnotationSign StatusLine
    hi link BookmarkAnnotationLine StatusLine

    " vim-gitgutter
    "let diff_bg = s:get_color('SignColumn', 'ctermbg')
    "exe 'hi GitGutterAdd ctermfg=' . s:get_color('DiffAdd', 'ctermbg')    . ' ctermbg=' . diff_bg
    "exe 'hi GitGutterChange ctermfg=' . s:get_color('DiffChange', 'ctermbg') . ' ctermbg=' . diff_bg
    "exe 'hi GitGutterDelete ctermfg=' . s:get_color('DiffDelete', 'ctermbg') . ' ctermbg=' . diff_bg
endfunction

augroup ColorOverrides
    au!
    au ColorScheme * call OverrideColors()
augroup END

set background=dark


let g:nord_cursor_line_number_background = 1
colorscheme nord

" Highlight group under cursor
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
