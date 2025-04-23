#!/bin/bash
## Shell script to run IQTREE species trees, gene trees, and concordance factors

# Notes:
# execute by typing `./iqtreerun.sh` at the terminal (MacOS) or git-bash terminal (Windows). 
#    If that fails try `bash iqtreerun.sh`, or look up the error message
# Output file prefix set by using the flag --prefix filename
# We can redirect input and ouput by adding relative paths indicated by 
# foldername prepended to filename like: foldername/filename, e.g. out/turtle.nex
# If you need to redo any of these analyses, add the `-redo` flag at the end of the command

# Inputs:
# turtle.fa  dna sequence alignment, in fasta format
# turtle.nex partitions indicating start/stop positions in the alignment, in nexus format

# check if directory out exists, if not, make it
if [ ! -d "$out" ]; then 
	mkdir out
  fi


## Species Trees ##

# infer the species tree with the simplest model - no partitions, all trees have 1000 ultrafast bootstraps 
iqtree2 -s input/turtle.fa --prefix out/concat -B 1000 -nt AUTO

# infer the species tree with an edge-linked fully-partitioned model (modelfinder)
iqtree2 -s input/turtle.fa -p input/turtle.nex --prefix out/species -B 1000 -nt AUTO

# infer the species tree fully-partitioned model with merging (partitionfinder) 
iqtree2 -s input/turtle.fa -p input/turtle.nex -m TEST+MERGE -rcluster 10 --prefix out/speciesmerge -bb 1000 -nt AUTO


## Gene Trees ##

# infer single-locus trees  
iqtree2 -s input/turtle.fa -S input/turtle.nex -m TEST --prefix out/loci -B 1000 


## Concordance factors ## 

# locus partitioned (modelfinder) species tree vs. single-locus trees 
iqtree2 -t out/species.treefile --gcf out/loci.treefile -s input/turtle.fa --scf 100 --prefix out/concord 
