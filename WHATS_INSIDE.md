# What's inside
This package contains:
* vim configuration
* vim plugins
* xterm configuration that plays nicely with vim
* tmux configuration
* couple of handy tools

I've started this repository just for .vimrc and plugins. A that time keeping everything in .vim directory seemed like a good idea.
Now, with other dotfiles and scripts it's kind of a mess, I guess adopting XDG directories might be a good idea.

## Requirements and third-party tools

Requirements:
* **[vim](https://www.vim.org/) >= 8.0** - my setup uses `ALE` and `vim-lsp` for linting and autocompletion, they depend on async jobs feature that was introduced in vim 8
* **[git](https://git-scm.com/) >= 1.8.3** - well, this package is a git repo, and vim plugins are git submodules. Also used by `fugitive` and `vim-airline` plugins
* **[ag](https://geoff.greer.fm/ag/)** - "the silver searcher", better grep. Used as `fzf` backend
* **[fzf](https://github.com/junegunn/fzf)** - fuzzy finder tool, tightly integrated with the setup as main searching tool for vim
* **[ctags](http://ctags.sourceforge.net/)** - code index generator with integrated vim support. Also used by `fzf.vim` (adds :Tags and :BTags searches)

C++:
* **[clang++](https://clang.llvm.org/)** - C++ linting (via `ALE` plugin)
* **[clangd](https://clang.llvm.org/extra/clangd.html)** - clang-based LSP implementation for C++ (autocompletion, code navigation via `vim-lsp`)
* **[cquery](https://github.com/cquery-project/cquery)** - Optional substitute for `clangd`
* **[bear](https://github.com/rizsotto/Bear)** - non-intrusive clang compilation database generator (needed for C++ LSPs to work properly)

python:
* **[python-language-server](https://github.com/palantir/python-language-server)** - LSP implementation for python (install with `pip`)
* **[pylint](https://www.pylint.org/)** - python linting (used via `ALE` plugin, install with `pip`)

Rust:
* **[cargo, rustc](https://rustup.rs/)** - Rust toolchain, linting (via `ALE` plugin, install with `rustup`)
* **[racer](https://github.com/racer-rust/racer)** - code completion (used by Rust RLS, install with `cargo`)
* **[rls](https://github.com/rust-lang-nursery/rls)** - Rust Language Server, LSP implementation for Rust (install with `cargo`)
* **[rustfmt](https://github.com/rust-lang-nursery/rustfmt)** - code formatting tool (install with `cargo`)

Others:
* **[python](https://www.python.org/)** - some tools are written in python, also used for json formatting as `jq` fallback.
* **[jq](https://stedolan.github.io/jq/)** - json query tool, used for json formatting
* **[xmllint](http://xmlsoft.org/xmllint.html)** - xml formatting
* **[xxd](https://linux.die.net/man/1/xxd)** - file to hex and back conversions

## Settings
Overview about tmux+xterm+vim setup
colors

### xterm
what settings do

### tmux
what settings do
mappings

### vim
what i use it for
8.0

#### Plugins
list of plugins with links and short explanation

#### Commands, mappings and snippets
quick howto

## Tools
my tools, profile.sh
