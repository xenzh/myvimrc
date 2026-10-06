# What's inside

This package contains:

- `zsh` (`oh-my-zsh`) and `nushell` configuration, aliases, plugins.
- `mise` for managing third-party tools.
- `tmux` setup + `tpm` plugins.
- `neovim`/`vim` configuration and plugins (native `pack` + `git` submodules).
- A coherent visual theme.
- Random small tools.

## Requirements and third-party tools

Most of these are installed and managed with [mise](https://mise.jdx.dev) from `mise/config.toml` (shared by `zsh` and `nushell`).

### Requirements

* **[git](https://git-scm.com/) >= 1.8.3** - version control, used to manage this installation. Used by some vim plugins (`fugitive`). *(OS package)*
* **[rg](https://github.com/BurntSushi/ripgrep)** - better grep. Used as `fzf` backend, in some tools and by `fzf.vim` (`:rg`). *(mise)*
* **[fzf](https://github.com/junegunn/fzf)** - fuzzy finder tool. Used in `zsh` profile tools and by `vim` plugins. *(mise)*
* **[nvim](https://neovim.io/)** - text editor/IDE. *(mise)*
  * **[vim](https://www.vim.org/)** - fallback editor (no `LSP`, limited linting). *(OS package)*
  * **[neovide](https://neovide.dev/)** - GUI frontend for Neovim *(OS package - mise has no prebuilt binary)*
* **[tree-sitter-cli](https://tree-sitter.github.io/tree-sitter/cli/index.html)** - required by `nvim-treesitter` for code syntax. *(mise)*

### C++

* **[clang++](https://clang.llvm.org/)** - C++ linting (via `ALE` plugin). *(OS package)*
* **[clangd](https://clang.llvm.org/extra/clangd.html)** - clang-based LSP (autocompletion, code navigation via `vim-lsp`) *(OS package)*
* Optional linters: `clang-tidy`.

### python

* **[python-lsp-server](https://github.com/python-lsp/python-lsp-server)** - LSP server, provides `pylsp`. *(mise, via `pipx:python-lsp-server`)*
* Optional linters: `black`, `ruff` *(mise)*, `mypy` *(mise, via `pipx:mypy`)*.

### Rust

* **[rustup](https://rustup.rs/)** - Rust installation manager.
    * **[cargo, rustc](https://rustup.rs/)** - Rust toolchain, linting (via `ALE` plugin, install with `rustup`).
    * **[clippy](https://doc.rust-lang.org/clippy/)** - linter (`rustup component add clippy`).
    * **[rustfmt](https://github.com/rust-lang-nursery/rustfmt)** - code formatter (an `ALE` fixer, `rustup component add rustfmt`).
    * **[rust-analyzer](https://rust-analyzer.github.io)** - LSP server (`rustup component add rust-analyzer`).

### Others

* **[bat](https://github.com/sharkdp/bat)** - syntax highlighter used by default for `fzf` previews and replaces `less`. *(mise)*
* **[python3](https://www.python.org/)** - some tools are written in python, also used for json formatting as `jq` fallback. *(OS package)*
* **[jq](https://stedolan.github.io/jq/)** - json query tool, used for json formatting. *(mise)*
* **[xmllint](http://xmlsoft.org/xmllint.html)** - xml formatting. *(OS package)*
* **[xxd](https://linux.die.net/man/1/xxd)** - file to hex and back conversions. *(ships with vim/OS)*
* **[zoxide](https://github.com/ajeetdsouza/zoxide)**, **[carapace](https://carapace.sh)**, **[starship](https://starship.rs)** - `z`/completions/prompt for both `zsh` and `nushell`. *(mise)*
* **[tmux](https://github.com/tmux/tmux)** - terminal multiplexer. *(mise)*

### Visuals

* **[Nord theme](https://www.nordtheme.com/)** - color overrides for host terminal emulator (otherwise vim/tmux will look funny).
* **[Nerd fonts](https://www.nerdfonts.com/#home)** - patched fonts that include Powerline symbols (vim/airline dependency).

## Artifacts

`vim` uses following files:

* `compile_commands.json` - (cwd) - clang compilation database (used natively by `clangd` and `ALE` plugin).

`zsh` uses following files:

* `~/.zcompdump-*` - dir history for `z` tool from omz.

## Settings

* Editors: `nvim`/`vim` in terminal or `Neovide` GUI.
* Workspace: `tmux` terminal multiplexer / sessions.
* Shell : `zsh` config based on `oh-my-zsh`; `nushell`.

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
* **[nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** - New text objects based on treesitter API (`nvim` only).
* **[nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)** - Show line context (class/function/heading) at the top (`nvim` only).

### Coding, language-specific

* **[rust.vim](https://github.com/rust-lang/rust.vim)** - Rust filetype, better syntax highlighting, formatting, `tagbar` integration
* **[vim-json](https://github.com/elzr/vim-json)** - better json highlighting and validation
* **[vim-toml](https://github.com/cespare/vim-toml)** - syntax highlighting for TOML
* **[csv.vim](https://github.com/chrisbra/csv.vim)** - column-based csv representation


## Tools

### [`dotfiles`](dotfiles)

Helper script for managing the installation:

* `./dotfiles install` - sources/links the configs into user's `$HOME`, sets up submodules, `mise` and OS packages.
* `./dotfiles update` - updates `mise`-managed tools and pulls the latest git submodules.

### [`profile.sh`](tools/profile.sh)

Profile aliases and tweaks (intended to be sourced to `.bashrc`, `.zshrc` or similar init scripts):

* Common aliases and functions for command like `clear`/`ls`
* `git` aliases with bash autocompletion
* `docker` aliases
* `cargo` aliases
* `vim` aliases and functions
* `fzf` config

### [`clangdb`](tools/clangdb)

Simple `python` script that automates some `compile_commands.json` tasks:

* generate compilation database for all `cpp` files in a folder based on `.clang` file with compilation flags.
* normalize file paths in databases generated by `bear` tool by making them absolute.

### [`preview`](tools/preview)

Script that provides an `fzf` preview for files and folders with syntax/line highlight.

### [`interactively`](https://github.com/bigH/interactively)

Run/edit a command interactively, preview results in real time. I.e. `interactively 'rg {} file.log'`.

### [`rgr`](tools/rgr)

Replace in-place with `rg`

### [`rgf`](tools/rf)

Interactive `rg` based on `fzf` with refresh-on-change.

### [`jqf`](tools/jqf)

Interactive `jq` shell based on `fzf` refresh-on-change.
