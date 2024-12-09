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
