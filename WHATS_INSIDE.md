# What's inside
This package contains:
* vim configuration
* vim plugins
* xterm configuration that plays nicely with vim
* tmux configuration
* profile tweaks
* couple of handy tools

I've started this repository just for .vimrc and plugins. A that time keeping everything in .vim directory seemed like a good idea.
Now, with other dotfiles and scripts it's kind of a mess, I guess adopting XDG directories might be a good idea.


## Requirements and third-party tools

### Requirements
* **[vim](https://www.vim.org/) >= 8.0** - this setup uses `ALE` and `vim-lsp` for linting and autocompletion, they depend on async jobs introduced in vim 8
* **[git](https://git-scm.com/) >= 1.8.3** - well, this package is a git repo, and vim plugins are git submodules. Also used by some plugins (like `fugitive`)
* **[ag](https://geoff.greer.fm/ag/)** - "the silver searcher", better grep. Used as `fzf` backend by default
* **[fzf](https://github.com/junegunn/fzf)** - fuzzy finder tool, tightly integrated with the editor as an internal search engine for nearly everything
* **[ctags](http://ctags.sourceforge.net/)** - code index generator, vim supports `ctags`-based navigation out-of-the-box. Also used by `fzf.vim` (:Tags and :BTags searches)

### C++
* **[clang++](https://clang.llvm.org/)** - C++ linting (via `ALE` plugin)
* **[clangd](https://clang.llvm.org/extra/clangd.html)** - clang-based LSP implementation for C++ (autocompletion, code navigation via `vim-lsp`)
* **[cquery](https://github.com/cquery-project/cquery)** - Optional substitute for `clangd`
* **[bear](https://github.com/rizsotto/Bear)** - non-intrusive clang compilation database generator (needed for C++ LSPs to work properly)

### python:
* **[python-language-server](https://github.com/palantir/python-language-server)** - LSP implementation for python (install with `pip`)
* **[pylint](https://www.pylint.org/)** - python linting (used via `ALE` plugin, install with `pip`)

### Rust:
* **[cargo, rustc](https://rustup.rs/)** - Rust toolchain, linting (via `ALE` plugin, install with `rustup`)
* **[racer](https://github.com/racer-rust/racer)** - code completion (used by Rust RLS, install with `cargo`)
* **[rls](https://github.com/rust-lang-nursery/rls)** - Rust Language Server, LSP implementation for Rust (install with `cargo`)
* **[rustfmt](https://github.com/rust-lang-nursery/rustfmt)** - code formatting tool (install with `cargo`)

### Others:
* **[highlight](https://andre-simon.de/docu/highlight/en/highlight.php)** - syntax highlighter used by default for `fzf` preview windows and `less`
* **[python](https://www.python.org/)** - some tools are written in python, also used for json formatting as `jq` fallback.
* **[jq](https://stedolan.github.io/jq/)** - json query tool, used for json formatting
* **[xmllint](http://xmlsoft.org/xmllint.html)** - xml formatting
* **[xxd](https://linux.die.net/man/1/xxd)** - file to hex and back conversions


## Artifacts

`vim` uses following files:
* `.lvimrc` - (any folder between cwd and home) - local vim config files
* `tags` - (any folder between cwd and home) - ctags output file, used for code navigation
* `.clang` - (any folder between cwd and home) - text file with C++ flags (see "C++ compile flags" feature)
* `compile\_commands.json` - (cmd) - clang compilation database (see "C++ compile flags" feature)


## Settings
My linux dev environment is essentially `vim` inside of `tmux` inside of `xterm`. Settings described below are to ensure that everyone in this chain plays nicely with the others.

### xterm
These settings are intended to be included in `.Xresources` or `.Xdefaults` file. They provide:
* Color and font settings for `xterm` terminal emulator
* Locale and keyboard settings for `vim` to function like it should

### tmux
These settings are intended to be directly used as `tmux` config file.
* General (mouse) settings, 256 color mode compatible with vim
* Colours unified with `vim`/`vim-airline`
* Additional keyboard mappings

### vim
Configuration is built mainly for C++/python/Rust development and includes a bunch of niceties to make editing a bit easier in general.

From development side it provides code highlighting, linting, autocompletion, quick files/tags navigation.

Interesting features:
* C++ compile flags

  Both `ALE` and `clangd` work best if provided with a set of compile flags for each file they process, `-I` in particular. There are several ways to specify them:
  * `compile_commands.json` - `clang` compilation database file, could be generated with `cmake` or tools like `bear`. Just put it in repo root folder, make sure it has right pathing (see `ccfix.py` tool), open vim and you're all set. Note that compilation database doesn't contain entries for header files - for them `vim` will try to get flags from matching cpp, and if it's missing will fall back to the next option.
  * `.clang` - if compilation database is missing or failed to load, `vim` tries to read `-I` flags from this file's lines and apply them to all h/cpp in this repo. Tools like `clang.vim` and `cquery` also accept files in this format, `clangd` doesn't.
  * `g:my_cpp_linter_flags` - specify flags manually in local vimrc file _(actually this might be broken)_.

* Interactive `jq` shell

  There is `:Jq` command for defined for `json` filetype. It opens one split for `jq` query and another for query result.
  I made this after getting tired of constant need to do `jq ... | head` to figure out json structure


For more details check out [mappings doc](MAPPINGS.md).


## VIM Plugins

### System
* **[pathogen.vim](https://github.com/tpope/vim-pathogen)** - runtimepath (plugin) manager
* **[fzf](https://github.com/junegunn/fzf)** and **[fzf.vim](https://github.com/junegunn/fzf.vim)** - search files, lines, history, mappings etc using integrated `fzf` command line tool
* **[async.vim](https://github.com/prabirshrestha/async.vim)** - async job control normalization library
* **[asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim)** - asynchronous autocompletion engine
  * **[asyncomplete-buffer.vim](https://github.com/prabirshrestha/asyncomplete-buffer.vim)** - source for buffed-based word completion
  * **[asyncomplete-tags.vim](https://github.com/prabirshrestha/asyncomplete-tags.vim)** - source for loaded tags
  * **[asyncomplete-file.vim](https://github.com/prabirshrestha/asyncomplete-file.vim)** - source for filenames
  * **[asyncomplete-lsp](https://github.com/prabirshrestha/asyncomplete-lsp.vim)** -  source for LSP client

* **[Localvimrc](https://github.com/embear/vim-localvimrc)** - _[to remove?]_ source `.lvimrc` local config files found in directories from cwd to home
* **[vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)** - visual bookmarks and annotations

### Behavior
* **[vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors)** - Sublime Text-like multiple cursors
* **[Rename](https://github.com/vim-scripts/Rename)** - rename file opened in current buffer
* **[Open file under cursor](https://github.com/amix/open_file_under_cursor.vim)** - opens file under cursor, duh

### UI
* **[vim-airline](https://github.com/vim-airline/vim-airline)** and **[vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)** - functional configurable statusbar written in pure vimscript; integrates with a bunch of other plugins.

### Coding, general
* **[ALE](https://github.com/w0rp/ale)** - Asynchronous Linting Engine: multilanguage code linting and fixing (plus rudimentary LSP client)
* **[vim-lsp](https://github.com/prabirshrestha/vim-lsp)** - asynchronous Language Server Protocol client
* **[fugitive](https://github.com/tpope/vim-fugitive)** - git integration, integrated with `vim-airline` (branch/status)
* **[tagbar](https://github.com/majutsushi/tagbar)** - code outline viewer, integrated with `vim-airline` (classpath)
* **[NERD Commenter](https://github.com/scrooloose/nerdcommenter)** - block comment/uncomment
* **[a.vim](https://github.com/vim-scripts/a.vim)** - quick switch between associated files (h/cpp, etc)

### Coding, language-specific
* **[vim.cpp](https://github.com/octol/vim-cpp-enhanced-highlight)** - additional C++ syntax highlighting
* **[rust.vim](https://github.com/rust-lang/rust.vim)** - Rust filetype, better syntax highlighting, formatting, `tagbar` integration
* **[vim-json](https://github.com/elzr/vim-json)** - better json highlighting and validation
* **[vim-toml](https://github.com/cespare/vim-toml)** - syntax highlighting for TOML
* **[csv.vim](https://github.com/chrisbra/csv.vim)** - column-based csv representation


## Tools
### [`myvimrc`](tools/myvimrc)
Simple helper script for adding/removing/updating vim plugins

### [`profile.sh`](tools/profile.sh)
Number of profile tweaks (this file is intended to be sourced to `.bashrc` or similar user config script)
* Common aliases and functions for command like `clear`/`ls`
* `git` aliases with bash autocompletion
* `vim` aliases and functions
* `fzf` config

### [`call`](tools/call)
`python` tool for decorating shell commands based on json templates. Check out the script for detailed explanation.

### [`ccfix.py`](tools/ccfix.py)
Quick-and-dirty `python` script to normalize file paths in `compile_commands.json` databases generated by `bear` tool. It makes them global and thus allows to store database files whereever without breaking the links (by default it has to reside in build folder).

