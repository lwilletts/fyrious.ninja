include config.mk

.PHONY: all feed clean

all: feed $(PAGES)

clean:
	rm -f $(PAGES) $(FEEDS)

.SUFFIXES: .md .html .xml

feed:
	@./feeds.sh index.md

.md.html:
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat - > $@
