file <- "ListsForLoops.qmd"

d <- readLines(file)             # read the lines 
lines <- d[grepl("\\code{", d, fixed=T)]       # select lines that start with Akaike 

gsub(".*?([0-9]+.[0-9]+).*", "\\1", lines)

gsub("(.*?)\\code{(.*)}(.*)", "\\1`\\2`\\3", lines, fixed=T)


lines <- gsub("\\code{", "`", lines, fixed=T)
lines <- gsub("}", "`", lines)