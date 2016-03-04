# Index your files with shell!
## 2016-03-04

I've been using nginx for sometime now, especially as it's configuration files
are much more /human/ friendly than Apache's, along with it being high
performance. Sadly one option has left me saddened at it's lack of
configuration - autoindex. My main gripe with it being that it's lacking the
option to show dotfiles, which I need to show .footprint and .md5sum files in
my [ports collection](/ports), also the output isn't fantastically pretty.
My solution to this is to generate the needed HTML with nothing but a shell
script. As I'm lazy, I added the following in my nginx.conf:

    add_before_body /html/head.html;
    add_after_body /html/foot.html;

This way I always have my header and footer showed on the page and I only have
to worry about generating the actual content, resulting in the following
piece of code:

        for port in $(find -type d | sed '1d'); do
            cd $port

            printf '%s' "<pre><code>" > index.html
            printf "<a href=\"../\">../</a>\n" >> index.html

            for file in $(ls -A); do
                test "$file" = "index.html" && continue
                date=$(du --time ${file} | awk '{print $2,$3}')
                size=$(du -hs ${file} | awk '{print $1}')

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

            cd ../
        done


Along with this small piece of CSS, to properly align the elements:

    #alignfile {
        display: inline-block;
        min-width: 600px;
    }

    #aligndata {
        min-width: 224px;
        display: inline-block;
    }

    #aligndate {
        float: left;
    }

    #alignsize {
        float: right;
    }


When I run `./ports.sh`, this will generate a index.html in each directory,
with anything that `ls -A` can find in that directory, along with a link to
the previous folder with the `../` reference. It's much more hackable too, as
I can now place any information in any format about the file I want!

## But wait! It gets better!

Now I want to get rid of autoindex completely for my [media](/media) folder
too, but now I unlike ports where I only have to generate the HTML when I copy
new Pkgfiles I have over on my system, I need to generate the HTML whenever I
delete, or create a file.

I use a similar script to the one above to create the HTML, but I also have
another script that starts [wendy](http://git.z3bra.org/wendy/log.html) an
event notifier that can be used to detect changes to a folder or a file, then
run a command. I'm simply using this command:

    wendy -m 768 -f ./media ./media.sh

Now when wendy detects a change in ./media, it'll run `media.sh` again to
regenerate the new HTML with the new file listed! I'm going to eventually figure
out a more 'fire-and-forget' way with using it with make, but now I can
finally say I generate all my HTML on my site with nothing but shell scripts!

For reference, all the scripts are [available in my website git repository.](https://github.com/Wildefyr/wildefyr.net)

Happy hacking!