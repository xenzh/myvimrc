# Puts mise-managed tools (nu/mise/config.toml) on PATH.
# Not `mise activate nu`: shims dispatch when called, avoid stale paths / reruns on new shell.

export-env {
    $env.PATH = ($env.PATH | prepend ($env.HOME | path join ".local" "share" "mise" "shims"))
}
