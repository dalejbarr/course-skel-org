# see .make_config file for course configuration
include .make_config

emacscmd := emacs --batch -l src/org-export-extra-setup.el 

default : deploy

.PHONY : book deploy slides web

deploy : slides web | $(htmldir)
	rsync -av $(htmldir)/ $(server):$(webroot)
	ssh $(server) 'find $(webroot) -type d -exec chmod a+rx {} \;'
	ssh $(server) 'find $(webroot) -type f -exec chmod a+r {} \;'

README.md : README.org
	$(emacscmd) README.org -f org-md-export-to-markdown # 2>/dev/null

book : | $(htmldir) public/book
	make -C public/book

html/slides :
	mkdir html/slides

html/slides/reveal.js : | html/slides
	wget -O /tmp/rvl.tar.gz https://github.com/hakimel/reveal.js/archive/3.9.2.tar.gz
	mkdir -p html/slides/reveal.js
	tar -C html/slides/reveal.js -xvzf /tmp/rvl.tar.gz --strip-components 1
	rm /tmp/rvl.tar.gz

slides : html/slides/reveal.js | $(htmldir)
	make -C public/slides

web : | $(htmldir)
	make -C public

$(htmldir) :
	mkdir $(htmldir)

clean :
	make -C public/book clean
	make -C public/slides clean
	make -C public clean

cleanserver :
	ssh $(server) 'rm -rf $(webroot)'
