#!/bin/sh
#
# wildefyr - 2016 (c) wtfpl
# use wendy to generate html when needed

HTMLROOT="/builds/wildefyr.net"

html() {
    printf '%s' "<pre><code>" > index.html
    printf "<a href=\"../\">../</a>\n" >> index.html

    find . -maxdepth 0 -exec ls -A {} \; | \
    while IFS= read -r file; do
        test "$file" = "index.html" && continue
        date=$(du --time "$file" | awk '{print $2,$3}')
        size=$(du -hs "$file" | awk '{print $1}')

        test "$size" = "0" && size="-"

        printf "\
<div id=\"alignfile\">\
<a href=\"${file}\">${file}</a>\
</div>\
<div id=\"aligndata\">\
<span id=\"alignsize\">${size}</span>\t\
<span id=\"aligndate\">${date}</span>\t\
</div>\n" >> index.html
    done

    printf '%s\n' "</code></pre>" >> index.html
}

# generate html
generate() {
    html

    for dir in */; do
        cd "$dir"
        html
        cd ../
    done
}

clean() {
    pkill wendy && printf '%s\n' "wendy killed!"

    find -name "index.html" -exec rm {} \;
}

cd "$HTMLROOT/media"

case $1 in
    clean) clean    ;;
    *)     generate ;;
esac
