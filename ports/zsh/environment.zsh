DOTS="$HOME/.dotfiles"
LOCALE="$HOME/.zsh/locale.sh"
test -f "$LOCALE" && . $LOCALE

umask 022

unset TERMCAP
unset MANPATH

# who needs C-q and C-s nowadays?
stty -ixon
stty start undef

EXECPATHS="\
/bin
/sbin
/usr/bin
/opt/bin
/usr/sbin
/opt/sbin
$DOTS/bin
$HOME/.fzf/bin
/builds/go/bin
/usr/local/bin"

printf '%s\n' "$EXECPATHS" | while read -r EXECPATH; do
    test -d "$EXECPATH" && export PATH="$PATH:$EXECPATH"
done

unset EXECPATH

export CC="/usr/bin/gcc"
export CXX="/usr/bin/g++"
export GOPATH="/builds/go"
export ruby="/usr/bin/ruby"

# misc.
export XDG_CONFIG_HOME="/home/wildefyr/.config"
export XDG_RUNTIME_DIR="/tmp/runtime-wildefyr"

export DL="$HOME/files/downloads"
export MUS="$HOME/files/music"
export VID="/media/storage/videos"
export IMG="/media/storage/pictures"
export BIN="$DOTS/bin"

export IMGVIEW="mpv --really-quiet --input-unix-socket=/tmp/imagesocket --loop-file"
export VIDPLAY="mpv --really-quiet --input-unix-socket=/tmp/mpvsocket"
export BROWSER="/usr/bin/google-chrome-stable"

# media extensions
test "$0" = "zsh" && {
    alias -s c="$EDITOR"
    alias -s md="$EDITOR"
    alias -s txt="$EDITOR"
    alias -s html="$EDITOR"

    alias -s gif="$IMGVIEW"
    alias -s png="$IMGVIEW"
    alias -s jpg="$IMGVIEW"
    alias -s jpeg="$IMGVIEW"
    alias -s webm="$IMGVIEW"

    alias -s mp4="$VIDPLAY"
    alias -s mkv="$VIDPLAY"
    alias -s mp4="$VIDPLAY"
}

# applications
alias i="$IMGVIEW"
alias mpvt="$VIDPLAY"
alias mpvi="$VIDPLAY --idle &!"
alias chrome="dtach -A /tmp/chrome -z $BROWSER"

type nvim 2>&1 > /dev/null && {
    export EDITOR="nvim"
} || {
    type vim 2>&1 > /dev/null && {
        export EDITOR="vim"
    } || {
        export EDITOR="vi"
    }
}

type vimpager 2>&1 > /dev/null && {
    export PAGER="vimpager"
    export MANPAGER="vimpager"
} || {
    export PAGER="less"
    export MANPAGER="less"
}

alias vi="$EDITOR"
alias vim="$EDITOR"
alias more="$PAGER"
alias emacs="emacs -nw"

test -f ~/.iouprc && export IOUP_TOKEN="$(cat ~/.iouprc)"
