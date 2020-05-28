vars <- yaml::yaml.load_file("_course.yaml")
makevars <- c("server", "webroot", "htmldir", "textdir")
outfile <- ".Makefile.config"

if (file.exists(outfile)) {
  file.remove(outfile)
}

purrr::walk(
         names(vars[makevars]),
         function(.n) {
           cat(.n, " := ", vars[[.n]], sep = "", "\n",
               file = outfile, append = TRUE) 
         })
