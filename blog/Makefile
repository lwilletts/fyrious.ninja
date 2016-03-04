include config.mk

.PHONY: all clean

all: $(PAGES) $(FEEDS)

clean:
	rm -f $(PAGES) $(FEEDS)

.SUFFIXES: .md .html .xml

$(FEEDS): index.md
	./feeds.sh $< > $@

.md.html:
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat - > $@
