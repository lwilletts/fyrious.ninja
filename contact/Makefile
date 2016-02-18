include config.mk

.PHONY: all clean

all: $(PAGES)

clean:
	rm -f $(PAGES)

.SUFFIXES: .md .html

HEADER = ../html/head.html
TITLE  = title.html
FOOTER = ../html/foot.html

.md.html: $(HEADER) $(TITLE) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) $(TITLE) - $(FOOTER) > $@
