MD       = /usr/bin/markdown
PAGES    = index.html start/index.html
SUBDIRS  = blog

.PHONY: all check clean site ports media new build

all: ports media site $(PAGES)

check:
	@./check.sh

ports:
	@./ports.sh

media:
	@./media.sh

clean:
	@echo "Cleaning: `pwd`"
	rm -f $(PAGES)
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done
	@echo "Cleaning: ports"
	@./ports.sh clean
	@echo "Cleaning: media"
	@./media.sh clean

site:
	@echo "Building: `pwd`"
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

new:
	@./blog/post.sh

build: clean all

.SUFFIXES: .md .html .xml

.md.html:
	@echo "MARKDOWN: `basename $@`"
	@$(MD) $< | cat - > $@
