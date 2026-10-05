# Shell aliases ported from `profile.sh`

export-env {
    $env.DOTFILES_ROOT = ($env.FILE_PWD | path join "..")
    $env.RIPGREP_CONFIG_PATH = ($env.DOTFILES_ROOT | path join ".ripgrep")
    $env.BAT_THEME = "Nord"
    $env.BAT_STYLE = "numbers,changes"
}

#
# basic aliases
#

alias q = exit
alias c = clear
alias l = ls -la
alias lt = ls -la | sort-by modified
def cl [] { clear; ls -la }
def ch [] { clear; tmux clear-history }
alias duh = du -a -d 1
alias bell = print "\u{07}"
def renv [pattern: string] {
    $env
    | transpose k v
    | where {|r| ($r.k =~ $pattern) or (($r.v | to text) =~ $pattern) }
}

#
# editor setup
#

def --wrapped vim [...rest] {
    if (which nvim | is-not-empty) { ^nvim ...$rest } else { ^vim ...$rest }
}
def --wrapped vimdiff [...rest] {
    if (which nvim | is-not-empty) { ^nvim -d ...$rest } else { ^vimdiff ...$rest }
}
def --wrapped edit [...rest] { vim ...$rest }
def --wrapped ":e" [...rest] { vim ...$rest }
def --wrapped vi [...rest] {
    vim -u ($env.DOTFILES_ROOT | path join "vim" ".vimrc.min") ...$rest
}

def --wrapped less [...rest] {
    if (which bat | is-not-empty) { ^bat ...$rest } else { ^less ...$rest }
}

#
# git aliases
#

alias g = git
alias gs = git status --ignore-submodules=dirty
alias gc = git checkout
alias gcb = git checkout -b
alias gb = git branch
alias gd = git diff
alias gpo = git push origin
alias gpu = git push upstream
alias grpo = git remote prune origin
alias ggc = git gc --aggressive --prune=now
alias gcd = cd (git rev-parse --show-toplevel | str trim)
alias gbd = git branch -d
alias gbdd = git branch -D

# branch-sync functions
def gbn [] { git rev-parse --abbrev-ref HEAD | str trim }
def gbb [] {
    git symbolic-ref refs/remotes/origin/HEAD
    | str trim
    | str replace "refs/remotes/origin/" ""
}
def gbs [] {
    print $"Unique commits in (gbb) / (gbn):"
    git rev-list --left-right --count $"(gbb)..(gbn)"
}
def gbl [] {
    let l = (gbb)
    let r = (gbn)
    git rev-list --left-right --pretty=oneline $"($l)..($r)"
    | lines
    | each {|line|
        if ($line | str starts-with ">") {
            $"[ ($l) ] -- ($line | str substring 1..)"
        } else {
            $"[ ($r) ] -- ($line | str substring 1..)"
        }
    }
}
def gcm [] { git checkout (gbb) }
def gmm [] { git merge (gbb) }
def gsu [] {
    git fetch upstream
    git checkout (gbb)
    git merge $"upstream/(gbb)"
    git push origin (gbb)
    git pull
}
def gpom [] { git push origin (gbb) }

# fzf-based git pickers
def gl [] {
    let pick = (
        git log --oneline --color=always
        | fzf --ansi --preview='git show --color=always {1}'
    )
    $pick | parse -r '^(?<hash>\S+)' | get hash.0?
}
def gll [] { git log --graph --color --oneline --decorate --all }
def gr [] {
    let hash = (gl)
    if ($hash | is-not-empty) { git rebase -i $hash }
}
def gbf [] {
    git branch
    | lines
    | each { str trim --char '*' | str trim }
    | str join "\n"
    | fzf --preview=$"git diff --color=always (gbb) {1}"
}
def gcf [] {
    let branch = (gbf)
    if ($branch | is-not-empty) { git checkout $branch }
}

#
# docker aliases
#

alias di = docker images
alias did = docker rmi
alias dc = docker ps -a
alias dcd = docker rm
alias dcp = docker container prune
def drm [] {
    let name = (
        docker container ls -a
        | lines
        | skip 1
        | each { split row -r '\s+' | last }
        | str join "\n"
        | fzf --preview='docker container logs {}'
    )
    if ($name | is-not-empty) { docker rm -f $name }
}
alias dv = docker volume ls
alias dvd = docker volume rm
def dvp [] {
    docker system df -v
    | lines
    | skip until {|l| $l starts-with "VOLUME NAME" }
    | skip 1
    | where {|l| ($l | split row -r '\s+' | get 2?) == "0B" }
    | each { split row -r '\s+' | first }
    | each {|v| docker volume rm $v }
}
alias dbp = docker builder prune -f --all
def dvc [from: string, to: string] {
    docker volume create --name $to
    docker run --rm -it -v $"($from):/from" -v $"($to):/to" alpine ash -c "cd /from && cp -av . /to"
}
alias dr = docker run
alias db = docker build
alias ds = docker stats
def dss [] {
    do { dvp } | ignore
    do { dbp } | ignore
    docker system df -v
}
alias dalp = docker run --rm -it alpine:latest ash

#
# rust/cargo aliases
#

alias cb = cargo build
def ccb [] { clear; cb }
alias cf = cargo fmt
alias cv = cargo clippy --workspace --all-targets --all-features -- -D warnings
alias ct = cargo test
alias cx = cargo run
def xcv [] { cargo build --all; cargo run }

#
# fzf file/grep pickers
#

def editf [opener: closure, dir: string = ""] {
    let loc = if ($dir | is-empty) {
        fzf | lines
    } else {
        let cwd = (pwd)
        cd $dir
        let picked = (fzf | lines)
        cd $cwd
        $picked | each {|p| $"($dir)/($p)" }
    }
    if ($loc | is-not-empty) {
        do $opener ...$loc
    }
}

def editg [opener: closure, pattern: string, dir: string = ""] {
    let cwd = (pwd)
    if ($dir | is-not-empty) { cd $dir }

    let preview = ($env.DOTFILES_ROOT | path join "tools" "preview")
    let picked = (
        rg --vimgrep $pattern
        | lines
        | parse -r '^(?<path>[^:]+):(?<line>\d+):(?<col>\d+):(?<text>.*)$'
        | each {|r| $"($r.path) ($r.line) ($r.text)" }
        | str join "\n"
        | fzf --preview=$"($preview) {1} {2}"
    )

    if ($dir | is-not-empty) { cd $cwd }

    if ($picked | is-not-empty) {
        let parts = ($picked | split row ' ')
        let loc = if ($dir | is-not-empty) { $"($dir)/($parts.0)" } else { $parts.0 }
        do $opener $loc $"+($parts.1)"
    }
}

def __get_oldfile_from_cmd [] {
    if (which nvim | is-not-empty) {
        nvim --headless +':new +setl\ buftype=nofile | 0put =v:oldfiles' +'w >> /dev/stdout' +qa!
        | lines
    } else {
        open ([$env.HOME ".viminfo"] | path join)
        | lines
        | where {|l| $l starts-with ">" }
        | each { str substring 2.. | str replace "~" $env.HOME }
    }
}

def edith [opener: closure] {
    let loc = (__get_oldfile_from_cmd | where {|l| not ($l | str ends-with "nvim") } | str join "\n" | fzf)
    if ($loc | is-not-empty) { do $opener $loc }
}

def editl [opener: closure] {
    let loc = (__get_oldfile_from_cmd | where {|l| not ($l | str ends-with "nvim") } | first | fzf -1)
    if ($loc | is-not-empty) { do $opener $loc }
}

def vimf [dir: string = ""] { editf {|...f| edit ...$f} $dir }
def vimg [pattern: string, dir: string = ""] { editg {|f, l| edit $f $l} $pattern $dir }
def vimh [] { edith {|f| edit $f} }
def viml [] { editl {|f| edit $f} }

def vinf [dir: string = ""] { editf {|...f| vin ...$f} $dir }
def ving [pattern: string, dir: string = ""] { editg {|f, l| vin $f $l} $pattern $dir }
def vinh [] { edith {|f| vin $f} }
def vinl [] { editl {|f| vin $f} }

def cdf [] {
    let dir = (
        ls **/* | where type == dir | where {|r| not ($r.name | str contains "/.") }
        | get name | str join "\n" | fzf
    )
    if ($dir | is-not-empty) { cd $dir }
}

def lf [] {
    let dir = (
        ls **/* | where type == dir | where {|r| not ($r.name | str contains "/.") }
        | get name | str join "\n" | fzf
    )
    if ($dir | is-not-empty) { ls $dir }
}
