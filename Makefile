emacscmd := emacs --batch -l src/org-export-extra-setup.el 

default : deploy

.Makefile.config : _course.yaml
	Rscript src/make_config.R

.PHONY : book deploy slides web

deploy : slides | $(htmldir)
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
	rm -f .Makefile.config
	make -C public/slides clean
	rm -rf $(htmldir)
# make -C public/book clean

cleanserver :
	ssh $(server) 'rm -rf $(webroot)'
