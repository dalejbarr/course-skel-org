SHELL := /bin/bash
include ../.make_config

# find all the files except those in 'slides' and 'book' subdirectories
# and trim off the path name
SRCS := $(shell find . -type f -regextype grep \
	-not -regex "^./\(slides\|book\).*" \
	-not -regex ".*~$$" \
	-not -regex "^./Makefile$$" \
	-not -regex "^./publish.el$$" -print | \
	sed 's|^./||')

# org files become html files
TARGS := $(patsubst %.org, %.html, $(SRCS))

# targets in the ../html directory
DTARGS := $(patsubst %, ../$(htmldir)/%, $(TARGS))

$(DTARGS) : $(SRCS)
	emacs --batch -l org \
		-l publish.el \
		index.org \
		--eval='(org-publish-project "org" t)'

# print :
#	@echo $(SRCS)
#	@echo $(DTARGS)

clean :
	find ../$(htmldir) -regextype grep \
		-not -regex '^../$(htmldir)/book.*' \
		-not -regex '^../$(htmldir)/slides.*' \
		-not -path ../$(htmldir) \
		-delete
