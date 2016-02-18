include config.mk

.PHONY: all package clean

all: $(PAGES)

clean:
	rm -f $(PAGES) $(NAME).tar.gz

.SUFFIXES: .md .html

HEADER = ../html/head.html
TITLE  = title.html
FOOTER = ../html/foot.html

.md.html: $(HEADER) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) $(TITLE) - $(FOOTER) > $@
