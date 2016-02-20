MD       = /usr/bin/markdown
PAGES    = index.html start/index.html
SUBDIRS  = blog

.PHONY: all check clean site

all: $(PAGES) site

check:
	@./check.sh

clean:
	rm -f $(PAGES)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

site:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

.SUFFIXES: .md .html .xml

HEADER = html/head.html
TITLE  = title.html
FOOTER = html/foot.html

.md.html: $(HEADER) $(TITLE) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) $(TITLE) - $(FOOTER) > $@
