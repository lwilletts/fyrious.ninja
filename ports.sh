#!/bin/sh
#
# wildefyr - 2016 (c) MIT
# build individual ports index.html to show hidden files

HTMLROOT="/builds/fyrious.ninja"

html() {
    cat 2> /dev/null > "index.html" << EOF
<table>
<tr class="header"><td><b>File</b></td><td><b>Last Modified</b></td><td><b>Size</b></td></tr>
<tr><td></td></tr>
<tr><td><a href=../>../</a></td></tr>
EOF

    ls -A -1 | while IFS= read -r file; do
        test "$file" = "index.html" && continue

        # date=$(du --time "$file" | awk '{print $2,$3}')
        size=$(du -hs "$file" | awk '{print $1}')

        test "$size" = "0" && size="-"
        directory=$(find -type d -name "${file}")
        test ! -z "$directory" && {
            file="$(printf '%s\n' "$directory" | cut -d'/' -f 2-)/"
        }

        cat 2> /dev/null >> "index.html" << EOF
<tr><td><a href="${file}">${file}</a></td><td>${date}</td><td>${size}</td></tr>
EOF
    done

    cat 2> /dev/null >> "index.html" << EOF
</table>
EOF
}

# generate html
generate() {
    for dir in */; do
        cd "$dir"
        html
        cd ../
    done
}

clean() {
    for dir in */; do
        cd "$dir"
        find . -name "index.html" -exec rm {} \;
        cd ../
    done
}

cd "$HTMLROOT/ports"

case $1 in
    clean) clean    ;;
    *)     generate ;;
esac
