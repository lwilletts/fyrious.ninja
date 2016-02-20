MD       = /usr/bin/markdown
PAGES    = index.html start/index.html
SUBDIRS  = blog

.PHONY: all check clean site echo build

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

echo:
	@echo

build: clean echo all

.SUFFIXES: .md .html .xml

HEADER = html/head.html
TITLE  = title.html
FOOTER = html/foot.html

.md.html: $(HEADER) $(TITLE) $(FOOTER)
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat $(HEADER) $(TITLE) - $(FOOTER) > $@
