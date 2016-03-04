MD       = /usr/bin/markdown
PAGES    = index.html start/index.html
SUBDIRS  = blog

.PHONY: all check clean site new build

all: site $(PAGES)

check:
	@./check.sh

clean:
	@echo "Cleaning: `pwd`"
	rm -f $(PAGES)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

site:
	@echo "Building: `pwd`"
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

new:
	@./blog/post.sh

build: clean all

.SUFFIXES: .md .html .xml

HEADER = html/head.html
FOOTER = html/foot.html

.md.html: $(HEADER) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) - $(FOOTER) > $@
