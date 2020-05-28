(require 'ox-publish)

(setq org-publish-project-alist
      `(
	("slides"
	 ;; :exclude "docs/.*"
	 :base-directory "~/psycloud/teaching/2019/L3_stats/course/root"
	 :base-extension "org"
	 :publishing-directory "~/psycloud/teaching/2019/L3_stats/course/root/docs"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :headline-levels 4
	 :html-head-extra ,my-css
	 :html-preamble t
	 :html-postamble ,my-postamble
	 )
	("org-static"
	 :exclude "docs/.*"
	 :base-directory "~/psycloud/teaching/2019/L3_stats/course/root"
	 :base-extension "css\\|png\\|jpg\\|gif\\|pdf\\|csv\\|rds\\|zip\\|R\\|Rmd\\|xls\\|xlsx\\|html\\|sav\\|mp4"
	 :publishing-directory "~/psycloud/teaching/2019/L3_stats/course/root/docs"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("org" :components ("org-notes" "org-static"))
	))
