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
| `F8`                  | n    | `vista.vim`, `ctags`, `vim-lsp` | Open side pane with document symbols                  |
| `ml`                  | n    | `vim-bookmarks`                 | Show all bookmarks in quickfix                        |
| `<leader>-1..9`       | n    | `vim-airline`                   | Go to arline tab \#                                   |
| `:Jsp`                | vcmd | `jq`/`python`                   | Show selection as formatted json in a split           |
| `:Jq`                 | cmd  | `jq`                            | Interactive `jq` shell with preview                   |
|                       | n    |                                 | * `<CR>` discard query buffer, jump to result buffer  |
|                       | n    |                                 | * `Esc` discard query and result buffers              |
| `:ToHex` `:FromHex`   | n    | `xxd`                           | Convert buffer to hex dump and read it back to text   |

### Navigation

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `:W` `:Q` `:Wq` `:WQ` | cmd  | _config_                        | Make w and q case insensitive                         |
| `:wd`                 | cmd  | _config_                        | Save and close current buffer (like `wq`)             |
| `:O`                  | cmd  | _config_                        | Close all buffers but this                            |
| `:Z`                  | cmd  | `fzf.vim`, `rg`                 | Close all buffers and open file finder                |
| `:Gr`                 | vcmd | _config_                        | Find selection, open quickfix with results            |
| `:Gre`                | cmd  | _config_                        | Display results of last search (`@/`) in quickfix     |
| `:set [no]magic`      | cmd  | _builtin_                       | Enable/disable regex match when searching             |
| `gf`                  | n    | `open file under cursor`        | Opens file under cursor                               |
| `[p`                  | n    | `fzf.vim`, `rg`                 | Find files in current working directory               |
| `]p`                  | n    | `fzf.vim`, `rg`                 | Find files in directory near current file             |
| `][p`                 | n    | `fzf.vim`, `rg`                 | Find files in ~                                       |
| `:F <dir>`            | cmd  | `fzf.vim`, `rg`                 | Find files in directory                               |
| `:fsp`                | cmd  | `fzf.vim`, `rg`                 | Open vertical split, find files in cwd                |
| `:rg <regex>`         | cmd  | `fzf.vim`, `rg`                 | Grep current working directory                        |
| `<F2>`                | n    | `fzf.vim`, `rg`                 | Grep current working directory with word under cursor |
| `\`                   | n    | `vista.vim`, `vim-lsp`, `ctags` | Search document symbols or tags                       |
| `;;` `gd`             | n    | `vim-lsp`                       | Go to symbol definition                               |
| `;l` `K`              | n    | `vim-lsp`                       | Show popup with hover info for a symbol               |
| `;'` `gr`             | n    | `vim-lsp`                       | Find symbol references                                |
| `gs` `gS`             | n    | `vim-lsp`                       | Document/workspace symbol search                      |
| `gi` `gt`             | n    | `vim-lsp`                       | Go to implementation/type definition                  |
| `,,`                  | n    | `ale`                           | Go to previous ALE diagnostic                         |
| `..`                  | n    | `ale`                           | Go to next ALE diagnostic                             |
| `[h` `]h`             | n    | `vim-gitgutter`                 | Go to previous/next git hunk                          |
| `[c` `]c`             | n    | _config_                        | Go to previous/next git merge conflict                |
| `mm`                  | n    | `vim-bookmarks`                 | Toggle bookmark at current line                       |
| `mi`                  | n    | `vim-bookmarks`                 | Add/edit/remove annotation at current line            |
| `ml` `ma`             | n    | `vim-bookmarks`                 | Toggle list all bookmarks                             |
| `mp` `mn`             | n    | `vim-bookmarks`                 | Go to to previous/next bookmark                       |
| `mc` `mx`             | n    | `vim-bookmarks`                 | Clear boormarks in current buffer/in all buffers      |

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

### Edit

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `C-k` `C-j`           | n, v | _config_                        | Bubble current line/selection up/down                 |
| `<` `>`               | v    | _config_                        | Indent selection and reselect                         |
| `gbb`                 | n    | `nvim-treesitter`               | Initiate AST visual selection.                        |
| `gbn`                 | v    | `nvim-treesitter`               | Expand selection to scope.                            |
| `gbv`                 | v    | `nvim-treesitter`               | Decrease selection by node.                           |
| `bgh`                 | v    | `nvim-treesitter`               | Expand selection by node.                             |
| `C-up` `C-down`       | n    | `vim-visual-multi`              | Add cursors downwards/upwards                         |
| `C-n`                 | n    | `vim-visual-multi`              | Start at current word/add at the next occurrence      |
| `<leader>-A`          | n    | `vim-visual-multi`              | Add cursor at each word in current file               |
| `g-Space` `\\\`       | n    | `vim-visual-multi`              | Add cursor at current position                        |
| `<leader>-c, l`       | n    | `NerdCommenter`                 | Comment selected lines with line comments (not block) |
| `<leader>-c, u`       | n    | `NerdCommenter`                 | Uncomment selected lines                              |
| `<leader>rn`          | n    | `vim-lsp`                       | LSP symbol rename                                     |
| `:Fmt`                | cmd  | _config_                        | Format source code (defined for a few filetypes)      |
| `:rn`                 | cmd  | `Rename`                        | Rename current file inplace                           |
| `:set noexpandtab`    | cmd  | _builtin_                       | `Tab` inserts tabs, not spaces.                       |


### Linting and completion

| Key                   | Mode | Source                          | Description                                           |
| --------------------- | ---- | ------------------------------- | ----------------------------------------------------- |
| `<F7>`                | n    | `asyncomplete.vim`              | Toggle completion popup and LSP client                |
| `C-Space`             | i    | _config_                        | Force show completion popup menu                      |
| `<F5>`                | n    | `ale`                           | Check syntax and open location list with diagnostics  |
| `:C`                  | cmd  | `ale`                           | Clear all diagnostics, close location list            |
| `:D`                  | cmd  | `ale`                           | Show preview window with diagnostics description      |
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
|                       |                                                         | `a` argument _targets.vim_                                 |
|                       |                                                         | `nb` any block _targets.vim_                               |
|                       |                                                         | `nq` any quote _targets.vim_                               |
|                       |                                                         | `f` function _nvim-treesitter-textobjects_                 |
|                       |                                                         | `c` class _nvim-treesitter-textobjects_                    |

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

## zsh, oh-my-zsh, plugins

* `Ctrl-O` - copy current command to clipboard (`copybuffer`).
* `Alt-Left/Right` - go up/down dir stack (`dirhistory`).
* `Alt-Up/Down` - go to parent/first child directory (`dirhistory`).
* `Ctrl-Z` - suspend command (i.e. vim, builtin), `fg`/`Ctrl-Z` again - resume (`fancy-ctrl-z`).
* `Ctrl-T` - find and paste file in current dir (`fzf` + omz plugin).
* `Ctrl-R` - find and paste a command from history (`fzf` + omz plugin).
* `Alt-C` - find and cd to a child folder (`fzf` + omz plugin).
