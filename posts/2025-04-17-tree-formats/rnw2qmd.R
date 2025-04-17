file <- "trees.Rnw"
mdsr::Rnw2Rmd(file, "_trees.qmd")

file <- "_trees.qmd"

x <- readLines(file)             # read the lines 

x <- gsub("(\\\\SweaveOpts)(.*$)", "", x)

# Rnw code tags to qmd
x <- gsub("(\\\\verb@)([a-zA-Z0-9 ,\\(\\)\\.]+)(@)", "`\\2`", x)
#x <- gsub("(\\")(\\\\code\\{)([^\\}]+)(\\}\\")", "`\\3`", x)
x <- gsub("(\\\\code\\{)([^\\}]+)(\\})", "`\\2`", x)
x <- gsub('\\"', "", x)

writeLines(x, "_trees_clean.qmd")


lines <- x[grepl("\\\\code\\{", x)]       # select lines that start with Akaike 

y <- lines[1]



y <- gsub("(\\\\code\\{)([^\\}]+)(\\})", "`\\2`", y)


lines <- d[grepl("\\code{", d, fixed=T)]       # select lines that start with Akaike 

gsub(".*?([0-9]+.[0-9]+).*", "\\1", lines)

gsub("(.*?)\\code{(.*)}(.*)", "\\1`\\2`\\3", lines, fixed=T)


lines <- gsub("\\code{", "`", lines, fixed=T)
lines <- gsub("}", "`", lines)


x <- gsub("(\\\\chapter\\{)([^\\}]+)(\\})", "# \\2", x)
