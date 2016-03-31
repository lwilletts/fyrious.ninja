type crux 2>&1 > /dev/null && {
    export PORTS="/usr/ports"

    alias prtrem="s prt-get remove"
    alias prtinst="s prt-get install"
    alias prtinsd="s prt-get depinst"
    alias prtupdate="s prt-get update"

    alias prtls="prt-get ls"
    alias prtedit="prt-get edit"
    alias prtpath="prt-get path"
    alias prtinfo="prt-get info"
    alias prtdiff="prt-get diff"
    alias prtread="prt-get readme"
    alias prtlist="prt-get listinst"
    alias prtsrch="prt-get dsearch"
    alias prtfsrch="prt-get fsearch"
    alias prtcache="prt-get cache"
    alias prtcount="prt-get listinst | wc -l"

    prtgo() {
        prtpath "$1" && cd $(prtpath "$1")
    }

    prtcat() {
        test -z $1 && {
            printf '%s\n' "Usage: prtcat [pkgname] <file>"
            return 1
        }

        package="$1"

        prt-get path "$package" > /dev/null && {
            packagePath=$(prt-get path "$package")
        } || {
            return 1
        }

        test -z "$2" && {
            test -f "${packagePath}/Pkgfile" && {
                vimcat "${packagePath}/Pkgfile"
            } || {
                printf '%s\n' "Pkgfile does not exist!"
                return 1
            }
        } || {
            shift
            for file in "$@"; do
                test -f "${packagePath}/${file}" && {
                    vimcat "${packagePath}/${file}"
                } || {
                    continue
                }
            done
        }

        unset -v package
    }

    prtdep() {
        test -z "$@" && {
            printf '%s\n' "Usage: prtdep [pkgname]"
            return 1
        }

        prt-get info "$@"

        deptree="$(prt-get deptree "$@" | sed '1d')"
        test ! -z "$deptree" && {
            printf '\n%s\n' "Package dependency tree:"
            prt-get deptree "$@" | sed '1d'
        } || {
            printf '\n%s' "$@ does not have any dependencies!"
        }

        dependent="$(prt-get dependent "$@")"
        test ! -z "$dependent" && {
            printf '\n%s\n' "Packages dependent:"
            printf '%s\n' "$dependent"
        } || {
            printf '\n%s\n' "$@ has no packages dependent on it!"
        }

        unset -v deptree dependent
    }

    prtupgrade() {
        s ports -u

        prt-get diff

        test ! -z "$(prt-get quickdiff)" && {
            printf '\n%s' "Upgrade Now? [Y/n]: "; while read -r confirm; do
                confirm=$(printf '%s\n' "$confirm" | tr '[A-Z]' '[a-z]')
                test "$confirm" = "n" && return 0 || break
            done
        }

        s prt-get sysup

        unset -v confirm
    }

    prtrebuild() {
        prtupdate $(prt-get quickdep "$1")
    }

    rebuildcore() {
        cd $PORTS/core
        ls -1 | while read -r port; do
            port=$(printf '%s\n' "$port" | rev | cut -d'/' -f 2 | rev)
            prtupdate -fr $port
        done

        unset -v port
    }

    fuckthisfuckthatfuckeverything() {
        sudo prt-get update $(prt-get listinst) -fr
    }

    buildkernal() {
        test -d "./arch" && {
            make
            modinstall
            instkern
            s depmod -a
        }
    }
}
