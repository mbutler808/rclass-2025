\documentclass[a4paper]{article}
\usepackage{fancyvrb}
\usepackage{color}

\author{Emmanuel Paradis}
\title{A Little Sweave Document}

\begin{document}

\maketitle

\section{Introduction}

This small document can be used as a Sweave template. It
uses minimal formatting of the text.

You can use Sweave with very little knowledge of LaTeX, but the
presentation of the text will be a little crude. Anyway, we have used
`author' and `title' that define these items before the document
begins. The command `maketitle' prints this information together with
the current data. Finally the command `section' defines numbered
sections within the text. All these commands are case-sensitive. That
will be all about LaTeX for the moment (but you may have noticed that
opening single quote is specified with a backquote... ;) ).

You know that R codes in a Sweave document starts with `< < > > =' and
ends with `@'. This last character should be followed either by a
white space, or by blank line (or both). Let's try it with some random data:

<<>>=
x <- rnorm(1000)
x[1:10]
@ 

Both input and output are printed. Suppose we want only the output:

<<echo=false>>=
y <- rnorm(1000)
y[1:10]
ls()
@ 

The options are specified within the `< < > > =' starting the R chunk. A
related option is `quiet=true' which suppresses the input, so some R
commands can be executed silently:

<<echo=false,quiet=true>>=
z <- rnorm(1000)
@ 

Let's check that it has run with a normal R chunck:

<<>>=
ls()
@ 

\section{Including Figures}

To have a plot included, we must add the option `fig=true' in the R
chunck header:

<<fig=true>>=
hist(x)
@ 

This will create two files in the working directory: a PDF version of
the plot, and an EPS one. The names of these files are created
automatically by Sweave. In case you don't know what is your R working directory:

<<>>=
getwd()
@ 

If you want to make many plots, it's useful to work in a distinct (sub)directory.

You can't really have several plot commands within the same R chunck,
but you can use `layout' to make several plots on the same figures:

<<fig=true>>=
layout(matrix(c(1, 2, 1, 3), 2))
plot(x, y)
hist(x)
hist(y)
@ 

Any R command can be put in the R chuncks. Let's read some data with ape:

<<>>=
library(ape)
data(woodmouse)
x <- woodmouse
x
@ 

The nice thing with Sweave is that you know exactly which data file
has been used since the code has been executed at the same time than
the document is printed!

Just for fun, let's plot the NJ tree done with a K80 distance:

<<fig=true>>=
plot(nj(dist.dna(x)))
add.scale.bar()
@ 

Not the proper way to do this kind of analysis, of course ;)

\section{Conclusion}

I hope this starter will give you the feel to write many Sweave
documents. A final word about LaTeX:    it
ignores                               extra
white                spaces
          between
words.

\end{document}
