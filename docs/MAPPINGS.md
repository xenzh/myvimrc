# Mappings and commands

## vim, `.vimrc`

`<leader>` key is `<space>`.

### Layout

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `:acl`                | cmd  | _config_                        | Close preview, quickfix, location list                |
| `F9`                  | n    | _config_                        | Resize split: decrease width                          |
| `F10`                 | n    | _config_                        | Resize split: increase width                          |
| `F11`                 | n    | _config_                        | Resize split: decrease height                         |
| `F12`                 | n    | _config_                        | Resize split: decrease height                         |
| `C-w` `C-r`           | n    | _builtin_                       | Rotate splits (swap contents)                         |
| `F8`                  | n    | `vista.vim`, `nvim_lsp`         | Open side pane with document symbols                  |
| `<leader>-1..9`       | n    | `vim-airline`                   | Go to airline tab \#                                  |
| `:Jsp`                | vcmd | `jq`/`python`                   | Show selection as formatted json in a split           |
| `:Jq`                 | cmd  | `jq`                            | Interactive `jq` shell with preview                   |
|                       | n    |                                 | * `<CR>` discard query buffer, jump to result buffer  |
|                       | n    |                                 | * `Esc` discard query and result buffers              |

### Buffers & files

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `:W` `:Q` `:Wq` `:WQ` | cmd  | _config_                        | Make w and q case insensitive                         |
| `:wd`                 | cmd  | _config_                        | Save and close current buffer (like `wq`)             |
| `:O`                  | cmd  | _config_                        | Close all buffers but this                            |
| `:Z`                  | cmd  | `fzf.vim`, `rg`                 | Close all buffers and open file finder                |
| `-`                   | n    | `oil.nvim`                      | Open file explorer                                    |
| `gf`                  | n    | _builtin_                       | Opens file under cursor                               |

### Search & find

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `[p`                  | n    | `fzf.vim`, `rg`                 | Find files in current working directory               |
| `]p`                  | n    | `fzf.vim`, `rg`                 | Find files in directory near current file             |
| `][p`                 | n    | `fzf.vim`, `rg`                 | Find files in ~                                       |
| `:F <dir>`            | cmd  | `fzf.vim`, `rg`                 | Find files in directory                               |
| `:fsp`                | cmd  | `fzf.vim`, `rg`                 | Open vertical split, find files in cwd                |
| `:rg <regex>`         | cmd  | `fzf.vim`, `rg`                 | Grep current working directory                        |
| `<F2>`                | n    | `fzf.vim`, `rg`                 | Grep current working directory with word under cursor |
| `:Gr`                 | vcmd | _config_                        | Find selection, open quickfix with results            |
| `:Gre`                | cmd  | _config_                        | Display results of last search (`@/`) in quickfix     |
| `:set [no]magic`      | cmd  | _builtin_                       | Enable/disable regex match when searching             |

### Code navigation

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `\`                   | n    | `vista.vim`, _nvim-lsp_         | Search document symbols                               |
| `;;` `gd`             | n    | _nvim-lsp_                      | Go to symbol definition                               |
| `;l` `K`              | n    | _nvim-lsp_                      | Show popup with hover info for a symbol               |
| `;'` `gr`             | n    | _nvim-lsp_                      | Find symbol references                                |
| `gi` `gt`             | n    | _nvim-lsp_                      | Go to implementation/type definition                  |
| `,,`                  | n    | _nvim-lsp_                      | Go to previous LSP diagnostic                         |
| `..`                  | n    | _nvim-lsp_                      | Go to next LSP diagnostic                             |
| `[h` `]h`             | n    | `vim-gitgutter`                 | Go to previous/next git hunk                          |
| `[c` `]c`             | n    | _config_                        | Go to previous/next git merge conflict                |
| `[o` `]o`             | n    | `nvim-treesitter-textobjects`   | Go to previous/next function argument                 |

### Bookmarks

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `mm`                  | n    | `vim-bookmarks`                 | Toggle bookmark at current line                       |
| `mi`                  | n    | `vim-bookmarks`                 | Add/edit/remove annotation at current line            |
| `ml` `ma`             | n    | `vim-bookmarks`                 | Toggle list all bookmarks                             |
| `mp` `mn`             | n    | `vim-bookmarks`                 | Go to previous/next bookmark                          |
| `mc` `mx`             | n    | `vim-bookmarks`                 | Clear bookmarks in current buffer/in all buffers      |

### View

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `<F6>`                | n    | _config_                        | Toggle line numbers and space chars                   |
| `<leader>-l` `:noh`   | n    | _config_                        | Clear search highlighting                             |
|`:set [no]wrap`        | cmd  | _builtin_                       | Enable/disable line wrapping                          |
| `zf`                  | v    | _builtin_                       | Create a fold                                         |
| `zo` `zc` `za`        | n    | _builtin_                       | Open, close, toggle one fold level under the cursor   |
| `zm` `zM`             | n    | _builtin_                       | Close next level/all folds                            |
| `zr` `zR`             | n    | _builtin_                       | Open next level/all folds                             |
| `<leader>-s`          | n    | _config_                        | Toggle spell checking                                 |
| `]s` `[s`             | n    | _builtin_                       | Next/previous spellcheck issue                        |
| `zg` `zug`            | n    | _builtin_                       | Add/remove a word to the spellfile                    |
| `z=`                  | n    | _builtin_                       | Spellcheck suggestions                                |

### Edit

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `C-k` `C-j`           | n, v | _config_                        | Bubble current line/selection up/down                 |
| `<` `>`               | v    | _config_                        | Indent selection and reselect                         |
| `m.`                  | n    | `nvim-treesitter-textobjects`   | Swap function argument with the next one              |
| `m,`                  | n    | `nvim-treesitter-textobjects`   | Swap function argument with the previous one          |
| `C-up` `C-down`       | n    | `vim-visual-multi`              | Add cursors downwards/upwards                         |
| `C-n`                 | n    | `vim-visual-multi`              | Start at current word/add at the next occurrence      |
| `<leader>-A`          | n    | `vim-visual-multi`              | Add cursor at each word in current file               |
| `g-Space` `\\\`       | n    | `vim-visual-multi`              | Add cursor at current position                        |
| `<leader>-c, l`       | n    | `NerdCommenter`                 | Comment selected lines with line comments (not block) |
| `<leader>-c, u`       | n    | `NerdCommenter`                 | Uncomment selected lines                              |
| `<leader>rn`          | n    | _nvim-lsp_                      | LSP symbol rename                                     |
| `<leader>ca`          | n    | _nvim-lsp_                      | LSP code actions                                      |
| `<leader>f`           | cmd  | _nvim-lsp_                      | Format source code (via LSP)                          |
| `:Fmt`                | cmd  | _config_                        | Format source code (defined for a few filetypes)      |
| `:rn`                 | cmd  | `Rename`                        | Rename current file inplace                           |
| `:set noexpandtab`    | cmd  | _builtin_                       | `Tab` inserts tabs, not spaces.                       |
| `:ToHex` `:FromHex`   | n    | `xxd`                           | Convert buffer to hex dump and read it back to text   |
| `:NoAnsiColors    `   | n    | _config_                        | Remove ANSI color codes from the buffer               |


### LSP & completion

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `<F7>`                | n    | _nvim-lsp_                      | Toggle LSP client for current buffer                  |
| `C-Space`             | i    | `nvim-cmp`                      | Force show completion popup menu                      |
| `:LL`                 | cmd  | `ale`                           | List ALE linters for current filetype                 |
| `:AL <name>`          | cmd  | `ale`                           | Enable ALE linter for current filetype                |
| `:DL <name>`          | cmd  | `ale`                           | Disable ALE linter for current filetype               |

### Text objects

`<count><command><kind><text object>`

| `<command>`           | `<kind>`                                                | `<text object>`                                            |
| --------------------- | ------------------------------------------------------- | ---------------------------------------------------------- |
| `v` select _builtin_  | `i` inside _builtin_                                    | `w` word _builtin_                                         |
| `d` delete _builtin_  | `a` outside _builtin_                                   | `s` sentence (dots) _builtin_                              |
| `c` change _builtin_  | `I<count><n/l>` inside w/o \S + next/last _target.vim_  | `p` paragraph (newlines) _builtin_                         |
|                       | `A<count><n/l>` outside w/o \S + next/last _target.vim_ | quotes _builtin_                                           |
|                       |                                                         | brackets _builtin_                                         |
|                       |                                                         | `, . ; : + - = ~ _ * # / \ & $` separators _targets.vim_   |
|                       |                                                         | `a` argument _targets.vim_ / _treesitter-textobjects_      |
|                       |                                                         | `nb` any block _targets.vim_                               |
|                       |                                                         | `nq` any quote _targets.vim_                               |
|                       |                                                         | `f` function _nvim-treesitter-textobjects_                 |
|                       |                                                         | `c` class _nvim-treesitter-textobjects_                    |

## tmux

Full `tmux` mappings reference: https://tmuxcheatsheet.com/
Prefix is `C-b` (default)

* `<prefix>, I` - reload `tmux` config
* `<prefix>, m` - enable mouse mode
* `<prefix>, M` - disable mouse mode
* `<prefix>, +` - promote pane to window
* `<prefix>, -` - demote windowed pane back
* `<prefix>, <` - move window tab to the right
* `<prefix>, >` - move window tab to the left
* `<prefix>, <prefix>, ...` - send controls to the nested session
* `<F12>` - toggle prefix and hotkeys (for routing them to nested sessions without double prefix)

## zsh, oh-my-zsh, plugins

* `Ctrl-O` - copy current command to clipboard (`copybuffer`).
* `Alt-Left/Right` - go up/down dir stack (`dirhistory`).
* `Alt-Up/Down` - go to parent/first child directory (`dirhistory`).
* `Ctrl-Z` - suspend command (i.e. vim, builtin), `fg`/`Ctrl-Z` again - resume (`fancy-ctrl-z`).
* `Ctrl-T` - find and paste file in current dir (`fzf` + omz plugin).
* `Ctrl-R` - find and paste a command from history (`fzf` + omz plugin).
* `Alt-C` - find and cd to a child folder (`fzf` + omz plugin).
