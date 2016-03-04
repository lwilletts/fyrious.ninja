include config.mk

.PHONY: all clean

all: $(PAGES) $(FEEDS)

clean:
	rm -f $(PAGES) $(FEEDS)

.SUFFIXES: .md .html .xml

HEADER = ../html/head.html
FOOTER = ../html/foot.html

$(FEEDS): index.md
	./feeds.sh $< > $@

.md.html: $(HEADER) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) - $(FOOTER) > $@
