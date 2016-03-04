#!/bin/sh
#
# wildefyr - 2016 (c) wtfpl
# use wendy to generate html when needed

HTMLROOT="/builds/wildefyr.net"

# test if there is a wendy instance, if not start one
wendyStart() {
    pgrep wendy 2>&1 > /dev/null || {
        wendy -m 960 -f . sh ../media.sh &
    }
}

# generate html
generate() {
    sleep 0.5
    for dir in $(find -type d); do
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

        test $(find -type d | head -n 1) != '.' && cd ../
    done
}

clean() {
    pkill wendy && printf '%s\n' "wendy killed!"

    for dir in $(find -type d); do
        cd $dir
        test -f index.html && rm index.html
        test $(find -type d | head -n 1) != '.' && cd ../
    done
}

cd "$HTMLROOT/media"

case $1 in
    clean)
        clean
        ;;
    *)
        wendyStart
        generate
        ;;
esac
