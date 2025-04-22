require(ggtree)
require(treeio)
require(ggplot2)
require(ape)


# Read in data
dat <- read.csv("anolis.SSD.raw.csv")
dat$gensp <- paste( "A",  dat$species, sep="_")
dat$lssd <- log(dat$mSVL/dat$fSVL)

# Read in tree
tree <- read.nexus("bigtree.nex")

# Plot tree
ggtree(tree) + 
	geom_tiplab(size=3) +
	xlim(0, 115)

# Check out the species names for matching keys
dat$gensp  # species names in dataset
tree$tip.label   # species names in tree 

# Tree names are truncated. Create matching label:
dat$label <- substring(dat$gensp, 1, 10)

# Merge tree and data on species names

tree2 <- full_join(tree, dat, by = "label") # This makes a mess
# This is a mess!  Must have same matching "label" in both tree and dat

# Subset tree by taxa in dat
# Use apeʻs drop.tip or keep.tip functions

smalltree <- ape::keep.tip(tree, dat$label)

# Plot tree
p <- ggtree(tree) + 
	geom_tiplab(size=3) +
	xlim(0, 115)
p

# Create treedata object from phylo + dataframe

ttree_treeonly <- as.treedata(smalltree)  # phyo -> treedata object, just the tree
ttree <- full_join(smalltree, dat, by = "label")  # treedata, tree + data

# Get just the data 

as_tibble(ttree)    # a tibble
as_tibble(ttree) %>% as.data.frame  # a dataframe

# Plot tree with node labels

ggtree(ttree) + 
	geom_tiplab(size=3) +
	xlim(0, 115) +
	geom_text(aes(label=node), hjust=-.3)

# Change tip labels
p <- ggtree(ttree) + 
	       geom_tiplab(aes(label=gensp), 
	 					size=3, 
	 					offset=.05, 
	 					fontface='italic' ) + 
	    xlim(0, 115) 

# Add node numbers
p +	theme_tree2() +  # adds timescale
	    geom_text(aes(label=node), hjust=-.3)    # node numbers

# Need to use geom_text2 for subsetting	
p +	theme_tree2() +  # adds timescale
	    geom_text2(aes(label=node, subset=!isTip), hjust=-.3)    # node numbers
	
	