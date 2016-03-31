# sys
alias s="sudo"
alias se="sudo -e"

alias sys="watch -n 1 -p \"df -h | grep '/dev/' | sort -h && printf '\n' && \
free -h && printf '\n' && ps xgf | sed '1d; s/--type.*//'\""

# permissions
alias chmox="chmod +x"
alias mine="s chown $(echo $USER):users"
alias all="mine -R *"

# operations
alias mount="s mount"
alias umount="s umount"

alias mv="mv -f"
alias cp="cp -rf"
alias rm="rm -rf"
alias mmv="noglob zmv -W"
alias rsync="rsync -arvp --progress -h"

alias l="ls"

type ccze 2>&1 > /dev/null && {
    alias ll="ls -lh | ccze -A"
    alias lla="ls -lha | ccze -A"
    alias lls="ls -lhs | ccze -A"
    alias llt="ls -lht | ccze -A"
    alias llx="ls -lhX | ccze -A"
    alias llsa="ls -lhsa | ccze -A"
    alias llta="ls -lhta | ccze -A"
    alias llxa="ls -lhXa | ccze -A"
} || {
    alias ll="ls -lh"
    alias lla="ls -lha"
    alias lls="ls -lhs"
    alias llt="ls -lht"
    alias llx="ls -lhX"
    alias llsa="ls -lhsa"
    alias llta="ls -lhta"
    alias llxa="ls -lhXa"
}

alias sz="du -hs"
alias t="clear; sz; tree"
alias sza="sz && sz * | sort -hr"
alias szt="t -h --du --sort=size"

alias szsh="source ~/.zshrc"
alias sxrdb="xrdb ~/.Xresources"

# net
alias iopaste="curl -sLT- https://p.iotek.org | xsel -i; xsel -o | xsel -ib"
alias ixpaste="curl -F \"f:1=<-\" ix.io | xsel -i; xsel -o | xsel -ib"

alias d="transmission-remote-cli"
alias yt="youtube-dl -x -o \"%(title)s.%(ext)s\""

alias externalip="curl -s icanhazip.com"
alias internalip="ifconfig | grep \"inet\" | cut -d\t -f 2 | cut -d\  -f 2 | \
cut -d: -f 2 | grep -v \"127.0.0.1\" | grep -v \"\n\""

# dtach / tmux
alias irc="dtach -A /tmp/irc -z weechat"
alias gog="dtach -A /tmp/gogs -z /builds/gogs/gogs"
alias mux="tmux attach || tmux new"

# misc.
alias motd="cat /etc/motd"
alias issue="cat /etc/issue"
alias unix="curl -L git.io/unix"
alias taco="curl -L git.io/taco"
alias tits="curl -L z3bra.org/tits"
alias happy="toilet -f term -w 200 -t --gay"
alias metal="toilet -f term -w 200 -t --metal"
alias gibberish="metal < /dev/urandom"
alias snake="terminibbles -d 3 -q"
alias matrix="cmatrix -ab -u 1"
alias engage="sox -c 2 -n synth whitenoise band -n 100 24 band -n 300 100 \
gain +4 synth whitenoise lowpass -1 100 lowpass -1 100 lowpass -1 100 gain +2"
