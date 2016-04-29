#!/bin/bash

uri="https://fyrious.ninja"
charset=utf-8
doctype=Inline
profile=css3

function w3c_valid () {
    if (curl -sI "$1" | grep -o 'Invalid' >/dev/null); then
        echo -e "[\033[1;31mFAIL\033[0m]"
        echo -e "  Errors : $1"
        exit 1
    fi
}

function rss_valid () {
    if (curl -s "$1"  | grep -o 'Sorry' >/dev/null); then
        echo -e "[\033[1;31mFAIL\033[0m]"
        echo -e "  Errors : $1"
        exit 1
    fi
}

# HTML files
check_html() {
    http=http://validator.w3.org/check
    count=0
    total=`find -name '*.html'|wc -l`
    for file in `find -name '*.html'`; do

        count=$(( $count+1 ))
        echo -ne "\rChecking HTML file(s) ... $count/$total"

        full_uri=${uri}/${file/.\//}
        check="${http}?uri=${full_uri}&charset=${charset}&$doctype=${doctype}"

        w3c_valid "$check"
        echo -ne "\rChecking HTML file(s) ... "
    done

    echo -e "[\033[1;32m OK \033[0m]"
}

# CSS files
check_css() {
    echo -n 'Checking CSS  file(s) ... '

    http=http://jigsaw.w3.org/css-validator/validator
    check="${http}?uri=${uri}&profile=${profile}"

    w3c_valid "$check"
    echo -e "[\033[1;32m OK \033[0m]"
}

# RSS feed
check_rss() {
    echo -n 'Checking RSS  file(s) ... '
    http=http://feedvalidator.org/check.cgi
    check="${http}?url=${uri}/rss/feed.xml"

    rss_valid "$check"
    echo -e "[\033[1;32m OK \033[0m]"
}

case $1 in
    html)   check_html ;;
    css)    check_css  ;;
    rss)    check_rss  ;;
    *)      check_html
            check_css
            check_rss  ;;
esac

exit 0
