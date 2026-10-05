# Apply starship prompt, defined in `starship.toml`.
#
# Like zoxide/carapace, starship's nu integration needs a *generated* init
# script on disk before this file is parsed (nu resolves `source` at parse
# time). Re-run after upgrading starship (brew upgrade starship):
#
#   starship init nu | save -f ~/.config/nushell/starship-init.nu

export-env {
    $env.STARSHIP_CONFIG = ($env.FILE_PWD | path join "starship.toml")
}

source ~/.config/nushell/starship-init.nu
