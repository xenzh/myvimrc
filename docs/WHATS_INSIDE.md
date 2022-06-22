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
  * **[vim](https://www.vim.org/) >= 8.0** - fallback editor (setup uses `ALE` and `vim-lsp` for linting and autocompletion, they require vim8+ async jobs)
* **[git](https://git-scm.com/) >= 1.8.3** - well, this package is a git repo, and vim plugins are git submodules. Also used by some plugins (like `fugitive`)
* **[rg](https://github.com/BurntSushi/ripgrep)** - grep, even better than `ag`. Used as default `fzf` backend, in some tools and by `fzf.vim` (:Rg, :Ag and :rg)
* **[fzf](https://github.com/junegunn/fzf)** - fuzzy finder tool, tightly integrated with the editor as an internal search engine for nearly everything
* **[universal-ctags](https://github.com/universal-ctags/ctags)** - code index generator. Used by vim natively, `fzf.vim` (:Tags, :BTags) and `vista.vim`.

### C++

* **[clang++](https://clang.llvm.org/)** - C++ linting (via `ALE` plugin)
* **[clangd](https://clang.llvm.org/extra/clangd.html)** - clang-based LSP implementation for C++ (autocompletion, code navigation via `vim-lsp`)

### python

* **[python-language-server](https://github.com/palantir/python-language-server)** - LSP implementation for python (install with `pip`)
* Optional linters: `pylint`, `black`, `flake8`, `mypy`.

### Rust

* **[cargo, rustc](https://rustup.rs/)** - Rust toolchain, linting (via `ALE` plugin, install with `rustup`)
* **[racer](https://github.com/racer-rust/racer)** - code completion (used by Rust RLS, install with `cargo`)
* **[rls](https://github.com/rust-lang-nursery/rls)** - Rust Language Server, LSP implementation for Rust (install with `cargo`)
* **[rustfmt](https://github.com/rust-lang-nursery/rustfmt)** - code formatting tool (install with `cargo`)

### Others

* **[highlight](https://andre-simon.de/docu/highlight/en/highlight.php)** - syntax highlighter used by default for `fzf` preview windows and `less`
* **[python](https://www.python.org/)** - some tools are written in python, also used for json formatting as `jq` fallback.
* **[jq](https://stedolan.github.io/jq/)** - json query tool, used for json formatting
* **[xmllint](http://xmlsoft.org/xmllint.html)** - xml formatting
* **[xxd](https://linux.die.net/man/1/xxd)** - file to hex and back conversions
* **[thefuck](https://github.com/nvbn/thefuck)** - fix last command, enabled by omz plugin.

### Visuals

* **[Nord theme](https://www.nordtheme.com/)** - color overrides for host terminal emulator (otherwise vim/tmux will look funny).


## Artifacts

`vim` uses following files:

* `tags` - (any folder between cwd and home) - ctags output file, used for code navigation
* `.clang` - (any folder between cwd and home) - text file with C++ flags (see "C++ compile flags" feature)
* `compile_commands.json` - (cwd) - clang compilation database (see "C++ compile flags" feature)

`zsh` uses following files:

* `~/.zcompdump-*` - dir history for `z` tool from omz.

## Settings

I use `vim`/`nvim` in terminal for development along with `zsh`, `tmux` and a terminal emulator. See below for their respective configurations and interations.

### terminal emulator

* MacOS: `iTerm2`
* Windows: `Windows Terminal` (`wt`) + WSL2 Debian.
* Nord-theme color overrides for standard terminal colors.

#### xterm (outdated, unused)

These settings are intended to be included in `.Xresources` or `.Xdefaults` file. They provide:

* Color and font settings for `xterm` terminal emulator
* Locale and keyboard settings for `vim` to function like it should
* TODO: integrate https://github.com/arcticicestudio/nord-xresources as a submodule

### tmux

These settings are intended to be directly used as `tmux` config file.

* General (mouse) settings, 256 color mode compatible with vim
* Colours unified with `vim`/`vim-airline`
* Additional keyboard mappings
* Plugins
* Custom statusline

### vim

Built for C++/python/Rust development, includes IDE-like features (code highlighting, linting, autocompletion, navigation), general editing improvements and custom commands.

### C++ compile flags

Both `ALE` and `clangd` work best if provided with a set of compile flags for each file they process, `-I` in particular. There are several ways to specify them:
  * `compile_commands.json` - `clang` compilation database file, could be generated with `cmake` or tools like `bear`. Just put it in repo root folder, make sure it has right pathing (see `clangdb` tool), open vim and you're all set. Note that compilation database doesn't contain entries for header files - for them `vim` will try to get flags from matching cpp, and if it's missing will fall back to the next option.
  * `.clang` - if compilation database is missing or failed to load, `vim` tries to read `-I` flags from this file's lines and apply them to all h/cpp in this repo. Tools like `clang.vim` and `cquery` natvely accept this file, `clangd` doesn't.

### Interactive `jq` shell

There is `:Jq` command for defined for `json` filetype. It opens one split for `jq` query and another for query result.
I made this after getting tired of constant need to do `jq ... | head` to figure out json structure

For more details check out [mappings doc](MAPPINGS.md).

## vim plugins

### System

* **[pathogen.vim](https://github.com/tpope/vim-pathogen)** - runtimepath (plugin) manager (by default vim8 pack manager is used, pathogen is a fallback for earlier vim versions)
* **[fzf](https://github.com/junegunn/fzf)** and **[fzf.vim](https://github.com/junegunn/fzf.vim)** - search files, lines, history, mappings etc using integrated `fzf` command line tool
* **[async.vim](https://github.com/prabirshrestha/async.vim)** - async job control normalization library
* **[asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)** - asynchronous autocompletion engine
  * **[asyncomplete-buffer.vim](https://github.com/prabirshrestha/asyncomplete-buffer.vim)** - source for buffed-based word completion
  * **[asyncomplete-tags.vim](https://github.com/prabirshrestha/asyncomplete-tags.vim)** - source for loaded tags
  * **[asyncomplete-file.vim](https://github.com/prabirshrestha/asyncomplete-file.vim)** - source for filenames
  * **[asyncomplete-lsp](https://github.com/prabirshrestha/asyncomplete-lsp.vim)** -  source for LSP client

* **[vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)** - visual bookmarks and annotations

### Behavior

* **[vim-visual-multi](https://github.com/mg979/vim-visual-multi)** - Sublime Text-like multiple cursors
* **[vim-sneak](https://github.com/justinmk/vim-sneak)** - jump to any location specified by two characters
* **[Rename](https://github.com/vim-scripts/Rename)** - rename file opened in current buffer
* **[Open file under cursor](https://github.com/amix/open_file_under_cursor.vim)** - opens file under cursor, duh

### UI

* **[vim-airline](https://github.com/vim-airline/vim-airline)** and **[vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)** - functional configurable statusbar written in pure vimscript; integrates with a bunch of other plugins.

### Coding, general

* **[ALE](https://github.com/w0rp/ale)** - Asynchronous Linting Engine: multilanguage code linting and fixing (plus rudimentary LSP client).
* **[vim-lsp](https://github.com/prabirshrestha/vim-lsp)** - asynchronous Language Server Protocol client.
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
* `vim` aliases and functions
* `fzf` config

### [`clangdb`](tools/clangdb)

Simple `python` script that automates some `compile_commands.json` tasks:

* generate compilation database for all `cpp` files in a folder based on `.clang` file with compilation flags.
* normalize file paths in databases generated by `bear` tool. It makes them global and thus allows to store database files whereever without breaking the links (by default it has to reside in build folder).

### [`preview`](tools/preview)

Script that provides a text preview for a number of `fzf`-searchable entities for `vim`.

### [`pctree.py`](tools/pctree.py)

Build package dependency tree based on `pkg-config`.

### [`rgr`](tools/rgr)

Replace in-place with `rg`

### [`rf`](tools/rf)

Interactive `rg` based on `fzf` with refresh-on-change

### [`call`](tools/call)

`python` tool for decorating shell commands based on json templates. Check out the script for detailed explanation.
