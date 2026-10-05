# zoxide + carapace integration.
#
# Both need a *generated* nu init script on disk before this file is parsed:
# nu resolves `source` targets at parse time, before any of this file's own
# code has run, so "generate then source in the same script" doesn't work.
# Re-run these after upgrading either tool (brew upgrade zoxide carapace):
#
#   zoxide init nushell --cmd z | save -f ~/.config/nushell/zoxide-init.nu
#   carapace _carapace nushell | save -f ~/.config/nushell/carapace-init.nu

export-env {
    # which shell completions to fall back on for commands carapace has no native spec for.
    $env.CARAPACE_BRIDGES = "zsh,fish,bash"
}

source ~/.config/nushell/zoxide-init.nu
source ~/.config/nushell/carapace-init.nu

#
# dirhistory (replaces the omz dirhistory plugin):
# Alt-Left/Right walk the directory stack instead of their default emacs-mode word-navigation.
#

use std/dirs

$env.config.keybindings = ($env.config.keybindings | append [
    {
        name: dirhistory_back
        modifier: alt
        keycode: left
        mode: [emacs, vi_normal, vi_insert]
        event: { send: executehostcommand, cmd: "dirs prev" }
    }
    {
        name: dirhistory_forward
        modifier: alt
        keycode: right
        mode: [emacs, vi_normal, vi_insert]
        event: { send: executehostcommand, cmd: "dirs next" }
    }
])

# `job unfreeze` resumes a job suspended with Ctrl-Z (nu's native fg). Ctrl-Z suspend works natively.
alias fg = job unfreeze
