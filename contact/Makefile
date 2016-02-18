include config.mk

.PHONY: all package clean

all: $(PAGES)

clean:
	rm -f $(PAGES) $(NAME).tar.gz

.SUFFIXES: .md .html

HEADER = head.html
FOOTER = foot.html

.md.html: $(HEADER) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) - $(FOOTER) > $@
