## Install/update necessary packages
#install.packages("installr")
#source("http://bioconductor.org/biocLite.R")
#?biocLite
#biocLite()
#biocLite("ggtree")
#biocLite("ggplot2")
#install.packages("ggplot2",type="source")
#install.packages("ggtree",type="source")
#update.packages()

## Load packages
library("ggtree")
library("grid")
library("ape")

## Assign names to colours
cols <- c("#32659f",  "#7571B4", "#006400", "#D2C161", "#9D7546", "#89A24C", "#EA9145", "#92c4de", "#76004D", "#be2f4b", "#EE96AD", "#ABABAB")
vals <-  c("B/Brisbane/60/2008", "B/Cambodia/30/2011", "B/Dakar/10/2012", "B/Florida/4/2006", "B/Harbin/7/1994", "B/Malaysia/2506/2004", "B/Massachusetts/2/2012", "B/Odessa/3886/2010", "B/Shanghai/361/2002", "B/Wisconsin/1/2010", "B/Yamanashi/166/1998", "other")
names(cols) <- vals
cols

## Trees
### SECTION 1-yam ###
#yamPB2
treeA <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PB2/yam/all_annotated_yam.PB2.mcc.tre")
mrsdA <- '2015-06-05'
treeA

#yamPB1
treeB <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PB1/yam/all_annotated_yam.PB1.mcc.tre")
mrsdB <- '2015-06-02'
treeB

##fluBPA
treeC <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PA/fluB/all_annotated_fluB.PA.mcc.tre")
mrsdC <- '2015-05-20'
treeC

##fluBNP
treeD <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NP/fluB/all_annotated_fluB.NP.mcc.tre")
mrsdD <- '2015-06-05'
treeD
######

### SECTION 1-vic ###
#vicPB2
treeA <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PB2/vic/all_annotated_vic.PB2.mcc.tre")
mrsdA <- '2015-05-20'
treeA

#vicPB1
treeB <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PB1/vic/all_annotated_vic.PB1.mcc.tre")
mrsdB <- '2015-05-20'
treeB

##fluBPA
treeC <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/PA/fluB/all_annotated_fluB.PA.mcc.tre")
mrsdC <- '2015-05-20'
treeC

##fluBNP
treeD <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NP/fluB/all_annotated_fluB.NP.mcc.tre")
mrsdD <- '2015-06-05'
treeD
######

### SECTION 2-yam ###
##yamHA
treeE <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/HA/yam/all_annotated_yam.HA.mcc.tre")
mrsdE <- '2015-06-21'
treeE

##yamNA
treeF <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NA/yam/all_annotated_yam.NA.mcc.tre")
mrsdF <- '2015-06-02'
treeF

##fluBM1
treeG <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/M1/fluB/all_annotated_fluB.M1.mcc.tre")
mrsdG <- '2015-06-10'
treeG

##yamNS1
treeH <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NS1/yam/all_annotated_yam-like.NS1.mcc.tre")
mrsdH <- '2015-06-03'
treeH
######

### SECTION 2-vic ###
##vicHA
treeE <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/HA/vic/all_annotated_vic.HA.mcc.tre")
mrsdE <- '2015-04-30'
treeE

##vicNA
treeF <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NA/vic/all_annotated_vic.NA.mcc.tre")
mrsdF <- '2015-06-08'
treeF

##fluBM1
treeG <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/M1/fluB/all_annotated_fluB.M1.mcc.tre")
mrsdG <- '2015-06-10'
treeG

##vicNS1
treeH <- read.beast("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/NS1/vic/all_annotated_vic-like.NS1.mcc.tre")
mrsdH <- '2015-05-13'
treeH
######

## Plots
## SECTION 1 ##
pA <- ggtree(treeA, mrsd=mrsdA, aes(color=PB2), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=PB2, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Vic PB2') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pB <- ggtree(treeB, mrsd=mrsdB, aes(color=PB1), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=PB1, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Vic PB1') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pC <- ggtree(treeC, mrsd=mrsdC, aes(color=PA), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=PA, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam/Vic PA') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pD <- ggtree(treeD, mrsd=mrsdD, aes(color=NP), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=NP, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam/Vic NP') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))

## SECTION 2 ##
pE <- ggtree(treeE, mrsd=mrsdE, aes(color=HA), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=HA, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam HA') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pF <- ggtree(treeF, mrsd=mrsdF, aes(color=NAx), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=NAx, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam NA') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pG <- ggtree(treeG, mrsd=mrsdG, aes(color=M1), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=M1, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam/Vic M1') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))
pH <- ggtree(treeH, mrsd=mrsdH, aes(color=NS1), size=0.3, right=FALSE) + scale_color_manual(na.value="#D6D6D6",values=cols) + theme_tree2() + geom_point2(aes(colour=NS1, subset=!is.na(as.numeric(posterior)) & posterior>0.7), size=0.5) + theme_tree2() + ggtitle('Yam NS1') + geom_text(aes(x=branch, label=substitutions), hjust=0.8, vjust=-.5, size=2) + scale_x_continuous(limits=c(1985,2015),breaks=scales::pretty_breaks(5))

## Layout
multiplot(pA, pB, pC, pD, ncol=2)
multiplot(pE, pF, pG, pH, ncol=2)

