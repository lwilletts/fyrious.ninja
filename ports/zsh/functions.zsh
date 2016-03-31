chpwd() {
    clear

    f0='[30m'; f1='[31m'; f2='[32m'; f3='[33m'
    f4='[34m'; f5='[35m'; f6='[36m'; f7='[37m'
    R='[0m'

    test $(ls -1 | wc -l) -gt 100 && {
        files=$(find -maxdepth 1 -type f | wc -l)
        links=$(find -maxdepth 1 -type l | wc -l)
        dirts=$(find -maxdepth 1 -type d | sed '1d' | wc -l)

        printf '%s\n' "$f3$files files ${R}&& $f6$dirts directories ${R}&& $f5$links links${R}"
    }

    test -z "$(ls -1)" && {
        printf '%s\n' "${f5}Directory is empty!${R}"
    } || {
        ls --color=auto -F -N
    }

    printf '\n'

    # set window title to path name
    print -Pn "\e]0;%~\a"
}

zshrc() {
    RWD=$PWD

    cd ~/.zsh
    $EDITOR *

    . ~/.zshrc

    test "$PWD" != "$RWD" && cd $RWD

    unset -v RWD
}

out() {
    PASTE="/tmp/paste"
    test -f "$PASTE" && cat "$PASTE"
    unset -v PASTE
}

dlog() {
    type ccze 2>&1 > /dev/null && {
        dmesg | tail -n 30 | ccze -A
    } || {
        dmesg | tail -n 30
    }
}

disks() {
    type ccze 2>&1 > /dev/null && {
        df -h | grep "/dev/" | sort -h | ccze -A
    } || {
        df -h | grep "/dev/" | sort -h
    }
}

psusr() {
    type ccze 2>&1 > /dev/null && {
        ps xgf "$@" | sed '1d; s/--type.*//' | ccze -A
    } || {
        ps xgf "$@" | sed '1d; s/--type.*//'
    }
}


pdf() {
    mupdf "$@" &!
}

mps() {
    mpsyt userpl wildefyri "$@"
}

findexec() {
    find . -maxdepth 1 -type f -executable | sort
}

editexec() {
    $EDITOR $(findexec) "$@"
}

findfile() {
    type ccze 2>&1 > /dev/null && {
        file $(find . -maxdepth 1) | sed '1d' | cut -c 3- | \
        grep -v ".git" | sort -k2 | ccze -A
    } || {
        file $(find . -maxdepth 1) | sed '1d' | cut -c 3- | \
        grep -v ".git" | sort -k2
    }
}
