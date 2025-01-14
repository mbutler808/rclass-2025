require(ggtree)
require(treeio)
require(ggplot2)

dat <- read.csv("anolis.SSD.raw.csv")
dat$species <- paste( "Anolis",  dat$species, sep="_")

dat$lssd <- log(dat$mSVL/dat$fSVL)

tree <- read.nexus("bigtree.nex")

ggtree(tree) + geom_tiplab(size=3) +
 xlim(0, 115)


