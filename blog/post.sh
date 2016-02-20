#!/bin/sh
#
# wildefyr - 2016 (c) wtfpl
# write a new post

color() {
    f0='[30m'; f1='[31m'; f2='[32m'; f3='[33m'
    f4='[34m'; f5='[35m'; f6='[36m'; f7='[37m'
    b0='[40m'; b1='[41m'; b2='[42m'; b4='[44m'
    b4='[44m'; b5='[45m'; b6='[46m'; b7='[47m'
    B='[1m'; R='[0m'; I='[7m'

    cat << COLOR
$f0$B$I$b6>$I$b7 $@ $I$b7$R
COLOR
}

printf '%s' "Title of post: "; while read -r title; do
    test -z "$title" && {
        color "Title cannot be empty."
        printf '%s' "Title of post: "
        continue
    }
    test -z "$(echo "$title" | grep -o "^[A-Z]")" && {
        color "Title should start with a capital letter."
        printf '%s' "Title of post: "
        continue
    }
    break
done

file=$(echo "$title" | tr -d ",.?!;\"'" | tr -s ' ' | tr ' ' '-' | sed "s/-*$//")

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

vim "${post}.md"
