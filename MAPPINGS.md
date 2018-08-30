# Mappings and commands

## vim, `.vimrc`

Following mappings and commands are added in `.vimrc`.
`<leader>` key is `\`.

### View

* `F6` - toggle line numbers and space chars (useful for working with system clipboard)
* `F8` - _tagbar_, toggle code outline view
* `ml` - _vim-bookmarks_, show all bookmarks

### Navigation

Split resize:
* `F9` - resize: descrease width
* `F10` - resize: increase width
* `F11` - resize: decrease height
* `F12` - resize: increase height

Switch between splits:
* `Ctrl-j` - move down
* `Ctrl-k` - move up
* `Ctrl-l` - move right
* `Ctrl-h` - move left

Switch airline tabs/buffers:
* `<leader>-<1-9>` - _vim-airline_, go to tab 1-9
* `<leader>-+` and `<leader-->` - _vim-airline_, go to next/previous tab

Search text and files:
* `:Gr` - find word under cursor, open quickfix with results
* `gf` - _open file under cursor_, jump to file
* `[p` - _fzf.vim_, search files in current working directory
* `]p` - _fzf.vim_, search files near current file
* `][p` - _fzf.vim_, search files in user home directory
* `[o` - _fzf.vim_, search tags in current working directory
* `]o` - _fzf.vim_, search tags in this buffer
* `][o` - _fzf.vim_, search all loaded tags

Code:
* `]c` and `[c` - jump to next/previous git merge marker
* `;;` - _LSP_, go to symbol definition
* `;'` - _LSP_, find references
* `;l` - _LSP_, symbol hover info
* `F5` - _ALE_, check syntax and open location list if there are warnings/errors
* `:C` - _ALE_, clean all error/warning indicators, close location list
* `:D` - _ALE_, show preview window with error/warning description

### Editing

General:
* `<` and `>` - indent selection and reselect
* `:W`, `:Q`, `:Wq`, `:WQ` - the same as `:wq`
* `:O` - close all buffers but this
* `:wd` - save and delete current buffer (just like `:wq` but for buffers)
* `:rn` - _Rename_, rename current file inplace

Code:
* `:Fmt` - _jq/python/xmllint_, format source code (only for few filetypes)
* `:Jsp` - _jq/python_, show selection as formatted json in a split. Useful when reading logs.
* `ToHex`, `FromHex` - _xxd_, convert buffer contents to hex dump and read it back


## vim, plugins/defaults/snippets

Following mappings/commands are defined by plugins or are vim defaults. I keep them here as a cheat sheet.

* `noh` - disable search results highlighting.
* `:set noexpandtab` - `Tab` inserts tabs, not spaces. Use when editing code intended with tabs.
* `:set wrap` / `:set nowrap` - enable/disable line wrapping.

## tmux

Full `tmux` mappings reference: https://tmuxcheatsheet.com/
Prefix is `Ctrl + b` (default)

* `<prefix>, r` - reload `tmux` config
* `<prefix>, m` - enable mouse mode
* `<prefix>, M` - disable mouse mode
* `<prefix>, +` - promote pane to window
* `<prefix>, -` - demote windowed pane back
* `<prefix>, <` - move window tab to the right
* `<prefix>, >` - move window tab to the left
