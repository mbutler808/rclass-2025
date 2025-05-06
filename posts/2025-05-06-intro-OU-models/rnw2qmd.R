#file <- c("OUCHintro.Rnw", "OUvariations.Rnw", "IC_OUCHexamples.Rnw", "handPGLS.Rnw")
#sapply(file, function(x) mdsr::Rnw2Rmd(x, paste("_", file, ".qmd", sep="")))

mdsr::Rnw2Rmd("OUCHintro.Rnw",  "_OUCHintro.qmd")
mdsr::Rnw2Rmd("OUvariations.Rnw",  "_OUvariations.qmd")
mdsr::Rnw2Rmd("IC_OUCHexamples.Rnw",  "_IC_OUCHexamples.qmd")
mdsr::Rnw2Rmd("handPGLS.Rnw",  "_handPGLS.qmd")


file <- "_handPGLS.qmd"

x <- readLines(file)             # read the lines 

x <- gsub("(\\\\SweaveOpts)(.*$)", "", x)

# Rnw code tags to qmd
x <- gsub("(\\\\verb@)([a-zA-Z0-9 ,\\(\\)\\.]+)(@)", "`\\2`", x)
#x <- gsub("(\\")(\\\\code\\{)([^\\}]+)(\\}\\")", "`\\3`", x)
x <- gsub("(\\\\code\\{)([^\\}]+)(\\})", "`\\2`", x)
x <- gsub('\\"', "", x)

writeLines(x, "_handPGLS_clean.qmd")


lines <- x[grepl("\\\\code\\{", x)]       # select lines that start with Akaike 

y <- lines[1]



y <- gsub("(\\\\code\\{)([^\\}]+)(\\})", "`\\2`", y)


lines <- d[grepl("\\code{", d, fixed=T)]       # select lines that start with Akaike 

gsub(".*?([0-9]+.[0-9]+).*", "\\1", lines)

gsub("(.*?)\\code{(.*)}(.*)", "\\1`\\2`\\3", lines, fixed=T)


lines <- gsub("\\code{", "`", lines, fixed=T)
lines <- gsub("}", "`", lines)


x <- gsub("(\\\\chapter\\{)([^\\}]+)(\\})", "# \\2", x)
