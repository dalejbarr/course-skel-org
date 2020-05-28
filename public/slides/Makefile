include ../../.make_config
emacscmd := emacs --batch -l ../../src/org-export-extra-setup.el -l org -l org-re-reveal

SRCS := $(wildcard */index.org)
TARGS := $(patsubst %.org, %.html, $(SRCS))
LNAME=XX_newlecture

all : localhtml

localhtml : $(TARGS) ../../.make_config
	rsync -av --delete \
		--exclude=index.org \
		--exclude=template \
		--exclude=*~ \
		--exclude=Makefile \
		--exclude=.git* \
		* ../../$(htmldir)/slides

$(TARGS) : $(SRCS)
	@echo "--- MAKING $@..."
	$(emacscmd) $< --eval '(org-re-reveal-export-to-html)'
	@echo "--- DONE."
	@echo ""

newslides :
	mkdir $(LNAME)
	cp -rv template/* $(LNAME)/

.PHONY : clean
clean : cleanhtml
	rm -f */index.html

cleanhtml :
	find ../../$(htmldir)/slides -regextype grep -not -regex "^../../$(htmldir)/slides/reveal.js.*" -not -path ../../$(htmldir)/slides -delete
