#!/bin/sh
#
# wildefyr - 2016 (c) wtfpl
# use wendy to generate html when needed

HTMLROOT="/builds/wildefyr.net"

# generate html
generate() {
    for dir in $(find $HTMLROOT/media -type d); do
        cd $dir || continue

        printf '%s' "<pre><code>" > index.html
        printf "<a href=\"../\">../</a>\n" >> index.html

        for file in $(ls -A); do
            test "$file" = "index.html" && continue
            date=$(du --time ${file} | awk '{print $2,$3}')
            size=$(du -hs ${file} | awk '{print $1}')

            test "$size" = "0" && size="-"

            printf "\
<div id=\"alignfile\">\
<a href=\"${file}\">${file}</a>\t\
</div>\
<div id=\"aligndata\">\
<span id=\"alignsize\">${size}</span>\t\
<span id=\"aligndate\">${date}</span>\t\
</div>\n" >> index.html
        done

        printf '%s\n' "</code></pre>" >> index.html

        cd ../
    done
}

clean() {
    pkill wendy && printf '%s\n' "wendy killed!"

    for dir in $(find $HTMLROOT/media -type d); do
        cd $dir
        test -f index.html && rm index.html
        cd ../
    done
}

cd "$HTMLROOT/media"

case $1 in
    clean) clean    ;;
    *)     generate ;;
esac
