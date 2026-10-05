# 1. fzf config ported from tools/profile.sh
# 2. nushell's official integration (vendored in the fzf submodule) for ctrl-t/ctrl-r/alt-c and completion.

export-env {
    $env.FZF_DEFAULT_COMMAND = "rg --hidden -l -g '!.git' -g '!*.o' -g '!*.d' ''"

    let colors = "bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"
    let preview = ($env.FILE_PWD | path join ".." "tools" "preview")
    $env.FZF_DEFAULT_OPTS = $"-m --preview=($preview)\\ {} --preview-window right:60% --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up,ctrl-j:preview-down,ctrl-k:preview-up --color=($colors)"
}

source ../vim/pack/2-bundle/start/fzf/shell/key-bindings.nu
source ../vim/pack/2-bundle/start/fzf/shell/completion.nu
