
## Install latest Bioconductor
#source("https://bioconductor.org/biocLite.R")
#biocLite()

## Install/update necessary packages
#source("http://bioconductor.org/biocLite.R")
#bioclite("ggplot2")
#biocLite("ggtree")
#install.packages("ggplot2",type="source")
#install.packages("ggtree",type="source")
#update.packages()

## Load packages
library("ggtree")
library("grid")
library("ape")

treeA <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/usa_vic.HA.mcc.tre")
treeB <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/europe_vic.HA.mcc.tre")
treeC <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/chinasea_vic.HA.mcc.tre")
treeD <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/oceania_vic.HA.mcc.tre")
treeE <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/usa_yam.HA.mcc.tre")
treeF <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/europe_yam.HA.mcc.tre")
treeG <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/chinasea_yam.HA.mcc.tre")
treeH <- read.nexus("/Users/pl6/0-Just_HA_NA/BSPs_2015-02-16/phylogenies/HA/oceania_yam.HA.mcc.tre")

##NA
## VIC
# pA <- ggtree(treeA, mrsd='2014-08-27', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
# pB <- ggtree(treeB, mrsd='2014-05-19', color='#094A89', size=0.3, right=TRUE) + theme_tree2()  + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5)) 
# pC <- ggtree(treeC, mrsd='2014-06-05', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
# pD <- ggtree(treeD, mrsd='2014-05-06', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))

## YAM
# pE <- ggtree(treeE, mrsd='2014-08-26', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
# pF <- ggtree(treeF, mrsd='2014-07-02', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
# pG <- ggtree(treeG, mrsd='2014-07-08', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
# pH <- ggtree(treeH, mrsd='2014-07-03', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))

##HA
## VIC
pA <- ggtree(treeA, mrsd='2014-07-31', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
pB <- ggtree(treeB, mrsd='2014-04-29', color='#094A89', size=0.3, right=TRUE) + theme_tree2()  + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5)) 
pC <- ggtree(treeC, mrsd='2014-05-26', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
pD <- ggtree(treeD, mrsd='2014-05-06', color='#094A89', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))

## YAM
pE <- ggtree(treeE, mrsd='2014-08-27', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
pF <- ggtree(treeF, mrsd='2014-07-02', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
pG <- ggtree(treeG, mrsd='2014-07-08', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))
pH <- ggtree(treeH, mrsd='2014-07-03', color='#B51E26', size=0.3, right=TRUE) + theme_tree2() + scale_x_continuous(limits=c(2000,2015),breaks=scales::pretty_breaks(5))

## Layout
multiplot(pA, pB, pC, pD, pE, pF, pG, pH, ncol=2)

# ## Test identify
# set.seed(123)
# tr <- rtree(60)
# p <- ggtree(tr, size=2)
# print(p)
# 
# cols <- rainbow(5)
# 
# for (i in 1:5){
#   p <- p + geom_balance(identify(p), fill=cols[i])
#   print(p)
# }
