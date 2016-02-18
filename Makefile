MD       = /usr/bin/markdown
PAGES    = index.html start/index.html

.PHONY: all check clean site

all: $(PAGES) site

check:
	@./check.sh

clean:
	rm -f $(PAGES)
	$(MAKE) -C blog clean
	$(MAKE) -C contact clean

site:
	$(MAKE) -C blog
	$(MAKE) -C contact

.SUFFIXES: .md .html .xml

HEADER = html/head.html
TITLE  = title.html
FOOTER = html/foot.html

.md.html: $(HEADER) $(TITLE) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) $(TITLE) - $(FOOTER) > $@
