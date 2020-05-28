# see .make_config file for course configuration
include .make_config

emacscmd := emacs --batch -l src/org-export-extra-setup.el 

default : deploy

.PHONY : book deploy slides web

deploy : book slides | $(htmldir)
	rsync -av $(htmldir)/ $(server):$(webroot)
	ssh $(server) 'find $(webroot) -type d -exec chmod a+rx {} \;'
	ssh $(server) 'find $(webroot) -type f -exec chmod a+r {} \;'

README.md : README.org
	$(emacscmd) README.org -f org-md-export-to-markdown # 2>/dev/null

book : | $(htmldir)
	make -C public/book

slides : | $(htmldir)
	make -C public/slides

web : | $(htmldir)
	make -C public web

$(htmldir) :
	mkdir $(htmldir)

clean :
	make -C public/slides clean

cleanserver :
	ssh $(server) 'rm -rf $(webroot)'
