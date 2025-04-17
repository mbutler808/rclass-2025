# Coercion  https://yulab-smu.top/treedata-book/chapter1.html#as-treedata
as.phylo (tree)
as.treedata(tree)

get.fields(beast_tree)  # just for beast trees?
get.data(beast_tree)   

# merging trees with data (exported from dplyr)
full_join(tree, dat, by="label")
p <- ggtree(tree_boots) %<+% df_tip_data + xlim(-.1, 4)


# merge two trees together 
merge_tree(tree1, tree2)

tree_subset(    # by node 
  tree,
  node,
  levels_back = 5,
  group_node = TRUE,
  group_name = "group",
  root_edge = TRUE
)

# Common ggtree functions

geom_tiplab()  adds tip labels
geom_rootedge() adds the root edge

geom_text(aes(label=label))
geom_label(aes(label=label))

# geom_label2 and geom_text2 allows subsetting
# for a phylo tree:
geom_label2(aes(label=label, 
      subset = !is.na(as.numeric(label)) & as.numeric(label) > 80))

geom_tippoint()
geom_nodepoint()



tr <- read.newick(nwk, node.label='support')
ggtree(tr) + geom_nodelab(geom='label', aes(label=support, subset=support > 80))

scale_color_continuous(low="yellow", high="purple")  # adds color scale for color aes set in for ggtree object
theme(legend.position="right") 

theme_tree2() # Adds time scale

as_tibble(ttree)    # a tibble

rtree(10)  # ape: generate random tree

get_taxa_name(ggtree)  # needs a ggtree 


