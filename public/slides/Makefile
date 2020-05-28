emacscmd := emacs --batch -l ../../src/org-export-extra-setup.el -l org -l org-re-reveal
SRCS := $(wildcard */index.org)
TARGS := $(patsubst %.org, %.html, $(SRCS))
LNAME=XX_newlecture

all : localhtml

localhtml : $(TARGS) ../../.Makefile.config
	rsync -av --delete \
		--exclude=template \
		--exclude=*~ \
		--exclude=Makefile \
		--exclude=.git* \
		* ../../html/slides

$(TARGS) : $(SRCS)
	@echo "--- MAKING $@..."
	$(emacscmd) $< --eval '(org-re-reveal-export-to-html)'
	@echo "--- DONE."
	@echo ""

newslides :
	mkdir $(LNAME)
	cp -rv template/* $(LNAME)/

.PHONY : clean
clean :
	rm -f */index.html
	rm -rf ../../html/slides
