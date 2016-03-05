#!/bin/sh
#
# wildefyr && z3bra - 2016 (c) MIT
# generate an atom rss feed from a markdown list

usage() {
    cat << EOF
Usage: $(basename $0) [file.md]
EOF

    test -z "$1" || exit $1
}

test -z "$1" && usage 1 || FILE="$1"
BASEURL="http://wildefyr.net"

cat > "feed.xml" << EOF
<?xml version='1.0'?>
<rss version='2.0' xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>wildefyr.net/blog</title>
<description>Musings on unix.</description>
<link>${BASEURL}/blog</link>
<atom:link href="${BASEURL}/blog/feed.xml" rel="self" />
EOF

postNum=$(wc -l < "$FILE")
postNum=$((postNum - 2))
posts=$(tail -${postNum} < "$FILE")

for i in $(seq $postNum); do
    post=$(printf '%s\n' "$posts" | sed "$i!d")
    printf '%s\n' "$post" | sed "s_* __; s_\[_<item><title>_; s_\]_</title>_; s_(_<guid>${BASEURL}_; s_)_</guid></item>_" >> feed.xml
done

cat >> "feed.xml" << EOF
</channel>
</rss>
EOF
