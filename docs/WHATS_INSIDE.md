# What's inside

This package contains:

* vim configuration and plugins
* tmux configuration
* xterm configuration
* zsh configuration, oh-my-zsh and plugins
* profile tweaks and tools


## Requirements and third-party tools

### Requirements

* **[nvim](https://neovim.io/)** - text editor/IDE.
  * **[vim](https://www.vim.org/)** - fallback editor (no `LSP`, limited linting).
  * **[neovide](https://neovide.dev/)** - GUI frontend for Neovim
* **[git](https://git-scm.com/) >= 1.8.3** - version control, used to manage this installation. Used by some vim plugins (`fugitive`)
* **[rg](https://github.com/BurntSushi/ripgrep)** - better grep. Used as `fzf` backend, in some tools and by `fzf.vim` (`:rg`)
* **[fzf](https://github.com/junegunn/fzf)** - fuzzy finder tool. Used in `zsh` profile tools and by `vim` plugins.

### C++

* **[clang++](https://clang.llvm.org/)** - C++ linting (via `ALE` plugin).
* **[clangd](https://clang.llvm.org/extra/clangd.html)** - clang-based LSP (autocompletion, code navigation via `vim-lsp`)
* Optional linters: `clang-tidy`.

### python

* **[python-lsp-server](https://github.com/python-lsp/python-lsp-server)** - LSP server (install with `pip`)
* Optional linters: `black`, `ruff`, `mypy`.

### Rust

* **[cargo, rustc](https://rustup.rs/)** - Rust toolchain, linting (via `ALE` plugin, install with `rustup`)
* **[rust-analyzer](https://rust-analyzer.github.io)** - LSP server (`rustup component add rust-analyzer`).
* **[clippy](https://doc.rust-lang.org/clippy/)** - linter (`rustup component add clippy`).
* **[rustfmt](https://github.com/rust-lang-nursery/rustfmt)** - code formatter (an `ALE` fixer, install with `cargo`).

### Others

* **[universal-ctags](https://github.com/universal-ctags/ctags)** - code index generator. Used by vim natively, optionally by `fzf.vim` (:Tags, :BTags) and `vista.vim`.
* **[bat](https://github.com/sharkdp/bat)** - syntax highlighter used by default for `fzf` previews and replaces `less`
* **[python3](https://www.python.org/)** - some tools are written in python, also used for json formatting as `jq` fallback.
* **[jq](https://stedolan.github.io/jq/)** - json query tool, used for json formatting
* **[xmllint](http://xmlsoft.org/xmllint.html)** - xml formatting
* **[xxd](https://linux.die.net/man/1/xxd)** - file to hex and back conversions

### Visuals

* **[Nord theme](https://www.nordtheme.com/)** - color overrides for host terminal emulator (otherwise vim/tmux will look funny).
* **[Powerline fonts](https://github.com/powerline/fonts)** - patched fonts that include Powerline symbols (vim/airline dependency).


## Artifacts

`vim` uses following files:

* `compile_commands.json` - (cwd) - clang compilation database (used natively by `clangd` and `ALE` plugin).

`zsh` uses following files:

* `~/.zcompdump-*` - dir history for `z` tool from omz.

## Settings

* Editors: `nvim`/`vim` in terminal or `Neovide` GUI.
* Workspace: `tmux` terminal multiplexer / sessions.
* Shell : `zsh` config based on `oh-my-zsh`.

### Terminal emulator

* MacOS: `iTerm2`
* Windows: WSL2 Debian + [`Tabby`](https://tabby.sh/).
* Nord-theme color overrides for standard terminal colors.

### tmux

These settings are intended to be directly used as `tmux` config file.

* General (mouse) settings, 256 color mode compatible with vim
* Colours unified with `vim`/`vim-airline`
* Additional keyboard mappings
* Plugins
* Custom statusline

### vim

Built for C++/python/Rust development, includes IDE-like features (code highlighting, linting, autocompletion, navigation), general editing improvements and custom commands.

### Interactive `jq` shell

There is `:Jq` command for defined for `json` filetype. It opens one split for `jq` query and another for query result.
I made this after getting tired of constant need to do `jq ... | head` to figure out json structure

For more details check out [mappings doc](MAPPINGS.md).

## vim plugins

### System

* **[pathogen.vim](https://github.com/tpope/vim-pathogen)** - runtimepath (plugin) manager (by default vim8 pack manager is used, pathogen is a fallback for earlier vim versions)
* **[fzf-lua](https://github.com/ibhagwan/fzf-lua)** - - search files, lines, history, mappings etc using integrated `fzf` command line tool.
    * **[fzf.vim](https://github.com/junegunn/fzf.vim)** - a fallback for `vim`.
* **[vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)** - visual bookmarks and annotations

### Behavior

* **[vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Sublime Text-like multiple cursors
* **[targets.vim](https://github.com/wellle/targets.vim)** - better and extra text objects
* **[Rename](https://github.com/vim-scripts/Rename)** - rename file opened in current buffer
* **[Open file under cursor](https://github.com/amix/open_file_under_cursor.vim)** - opens file under cursor, duh

### UI

* **[vim-airline](https://github.com/vim-airline/vim-airline)** and **[vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)** - functional configurable statusbar written in pure vimscript; integrates with a bunch of other plugins.

### Coding, general

* **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) -- code completion (only in `neovim`).
    * completion sources, i.e. LSP, LSP-signature, path, calc, buffer.
* **[ALE](https://github.com/w0rp/ale)** - linting and fixing, `vim` / LSP fallback.
* **[vista.vim](https://github.com/liuchengxu/vista.vim/)** - code outline viewer and searcher, integrated with `fzf`, `ctags` and `vim-lsp`.
* **[fugitive](https://github.com/tpope/vim-fugitive)** - git integration, integrated with `vim-airline` (branch/status).
* **[vim-gitgutter](https://github.com/airblade/vim-gitgutter)** - inline git diff signs, integrated with `vim-airline` (diff summary).
* **[vim-gutentags](https://github.com/ludovicchabant/vim-gutentags)** - automatic management for project tag files.
* **[NERD Commenter](https://github.com/scrooloose/nerdcommenter)** - block comment/uncomment.
* **[a.vim](https://github.com/vim-scripts/a.vim)** - quick switch between associated files (h/cpp, etc).
* **[nvim-treesitter](https://github.com/nvim-treesitter)** - AST parser, syntax highlighter (`nvim` only).
* **[nvim-treesitterr-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** - New text objects based on treesitter API (`nvim` only).

### Coding, language-specific

* **[rust.vim](https://github.com/rust-lang/rust.vim)** - Rust filetype, better syntax highlighting, formatting, `tagbar` integration
* **[vim-json](https://github.com/elzr/vim-json)** - better json highlighting and validation
* **[vim-toml](https://github.com/cespare/vim-toml)** - syntax highlighting for TOML
* **[csv.vim](https://github.com/chrisbra/csv.vim)** - column-based csv representation


## Tools

### [`myvimrc`](tools/myvimrc)

Simple helper script for adding/removing/updating vim plugins (broken).

### [`profile.sh`](tools/profile.sh)

Number of profile tweaks (this file is intended to be sourced to `.bashrc` or similar user config script):

* Common aliases and functions for command like `clear`/`ls`
* `git` aliases with bash autocompletion
* `docker` aliases
* `cargo` aliases
* `vim` aliases and functions
* `fzf` config

### [`clangdb`](tools/clangdb)

Simple `python` script that automates some `compile_commands.json` tasks:

* generate compilation database for all `cpp` files in a folder based on `.clang` file with compilation flags.
* normalize file paths in databases generated by `bear` tool. It makes them global and thus allows to store database files whereever without breaking the links (by default it has to reside in build folder).

### [`preview`](tools/preview)

Script that provides an `fzf` preview for files and folders with syntax/line highlight.

### [`interactively`](https://github.com/bigH/interactively)

Run/edit a command interactively, preview results in real time. I.e. `interactively 'rg {} file.log'`.

### [`pctree.py`](tools/pctree.py)

Build package dependency tree based on `pkg-config`.

### [`rgr`](tools/rgr)

Replace in-place with `rg`

### [`rgf`](tools/rf)

Interactive `rg` based on `fzf` with refresh-on-change.

### [`jqf`](tools/jqf)

Interactive `jq` shell based on `fzf` refresh-on-change.

### [`call`](tools/call)

`python` tool for decorating shell commands based on json templates. Check out the script for detailed explanation.
