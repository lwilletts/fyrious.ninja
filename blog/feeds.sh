#!/bin/sh

usage() {
    cat << EOF
Usage: $(basename $0) [file.md]
EOF

    test -z "$1" || exit $1
}

test -z "$1" && usage 1 || FILE="$1"
BASEURL="http://wildefyr.net"

cat << EOF
<?xml version='1.0'?>
<rss version='2.0'>
<channel>
<title>wildefyr.net/blog</title>
<description>Musings on unix.</description>
<link>${BASEURL}/blog</link>
EOF

postNum=$(wc -l < "$FILE")
postNum=$((postNum - 2))
posts=$(cat "$FILE" | tail -${postNum})

for i in $(seq $postNum); do
    post=$(echo "$posts" | sed "$i!d")
    echo "$post" | sed "s_* __; s_\[_<item><title>_; s_\]_</title>_; s_(_<guid>${BASEURL}_; s_)_</guid></item>_"
done

cat << EOF
</channel>
</rss>
EOF
