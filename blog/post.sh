#!/bin/sh
#
# wildefyr && z3bra - 2016 (c) wtfpl
# write a new post

HTMLROOT="/builds/wildefyr.net"
cd "$HTMLROOT/blog"

printf '%s' "Title of post: "; while read -r title; do
    test -z "$title" && {
        printf '%s\n' "Title cannot be empty."
        printf '%s' "Title of post: "
        continue
    }
    test -z "$(echo "$title" | grep -o "^[A-Z]")" && {
        printf '%s\n' "Title should start with a capital letter."
        printf '%s' "Title of post: "
        continue
    }
    break
done

file=$(printf '%s\n' "$title" | tr -d ",.?!;\"'" | tr -s ' ' | tr ' ' '-' | \
    sed "s/-*$//")

date=$(date +%Y-%m-%d)
folder=$(date +%Y/%m)
test ! -d "$folder" && mkdir -p "$folder"

post="$folder/$file"

# insert hyperlink
sed -i "3i * [$title](/blog/${post}.html)" index.md
# insert post into config.mk
printf '\t\t%s' " ${post}.html \\" >> config.mk

# create post
cat << EOF > "${post}.md"
# $title
## $date

EOF

$EDITOR "${post}.md"
