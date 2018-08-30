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
* _fzf.vim_, search files
  * `[p` - in current working directory
  * `]p` - near current file
  * `][p` -in user home directory
* _fzf.vim_, search tags
  * `[o` - in current working directory
  * `]o` - in this buffer
  * `][o` - all loaded tags

Code:
* `]c` and `[c` - jump to next/previous git merge marker
* _vim-lsp_
  * `;;` - go to symbol definition
  * `;'` - find references
  * `;l` - symbol hover info
* _ALE_
  * `F5` - check syntax and open location list if there are warnings/errors
  * `:C` - clean all error/warning indicators, close location list
  * `:D` - show preview window with error/warning description


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

* Default
  * `noh` - disable search results highlighting.
  * `:set noexpandtab` - `Tab` inserts tabs, not spaces. Use when editing code intended with tabs.
  * `:set wrap` / `:set nowrap` - enable/disable line wrapping.
  * tags
    * `Ctrl-]` - go to definition of symbol under cursor
    * `:ta` - go to symbol definition
    * `g]` - list symbol definitions
    * `Ctrl-t` - go back
* Plugins
  * vim-bookmarks
    * `mm` -- toggle bookmark at current line
    * `mi` - add/edit/remove annotation at current line
    * `ma` - _[remapped to `ml`]_ - toggle list all bookmarks
    * `mn`, `mp` - jump to next/prev bookmark
    * `mc`, `mx` - clear boormarks in current buffer/in all buffers
  * NERD Commenter
    * `<leader>-c, l` - comment selected lines with line comments (not block)
    * `<leader-c, u>` - uncomment selected lines


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
