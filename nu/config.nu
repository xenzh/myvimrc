# config.nu
#
# Installed by:
# version = "0.111.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# Install:
# ln -s ~/.dotfiles/nu/config.nu ~/.config/nushell/config.nu

$env.config.show_banner = false

alias q = exit
alias c = clear
alias l = ls -a

def cl [] {
    c
    l
}

def --env mkcd [dir: string] {
    mkdir $dir
    cd $dir
  }


def is_installed [ app: string ] {
  ((which $app | length) > 0)
}

let has_nvim = is_installed nvim
if $has_nvim {
    alias vim = nvim £ # conditional alises do not work it seems
}

alias vi = vim -u ~/.dotfiles/../vim/.vimrc.min
