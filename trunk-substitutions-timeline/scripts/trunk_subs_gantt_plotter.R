## installations
#biocLite("ggtree")
#biocLite("ggplot2")
#biocLite("ggrepel")
#biocLite("gridExtra")

## Load libraries
library(ggplot2)
library(ggrepel)
library(grid)
library(gridExtra)
## Load data file
df <- read.csv("/Users/pclangat/Documents/Professional/OldProjects/2-FluB/0-alignments_2015-08-25/12-Global_mccts/4-Trunk_mutations/version2/summaries/timeline/all_fluB.trunk_sub_dates_x.csv", header = TRUE, stringsAsFactors = FALSE)
value <- nrow(df)
df$hj <- rep(c(-1, -2.5), length.out=value)
df$segment
df$segment <- factor(df$segment, levels=c("NS1", "M1", "NAx", "NP", "HA", "PA", "PB1", "PB2", "X"))
df$segment

#myplot<-ggplot(df)+geom_line(aes(Value1, Value2, group=ID, colour=ID))
#myplot %+% subset(df, ID %in% c("P1","P3"))
#myplot %+% subset(df, ID %in% c("P2"))

## Assign names to colours
cols <- c("#d6d6d6",  "#70296f", "#bb89b7", "#983c92", "#005f9b", "#00be67", "#89a24c", "#f39123", "#fccb0a")
vals <-  c("X", "PB2", "PB1", "PA", "HA", "NP", "NAx", "M1", "NS1")
names(cols) <- vals
cols

#p <- ggplot(subset(df, lineage %in% c("Yam-2")))
p <- ggplot(df) + scale_color_manual(na.value="#D6D6D6",values=cols) 
p <- p + theme_bw() + aes(colour=segment) + scale_x_continuous(limits = c(1995, 2015))
p <- p + theme(legend.position="none", axis.title.x=element_blank(), axis.title.y=element_blank())
p <- p + geom_segment(aes(x=date_95HPD_low, xend=date_95HPD_high,
                          y=segment, yend=segment), size=1)
p <- p + geom_point(aes(x=date, y=segment), size=2)
p <- p + geom_text(aes(x=date, y=segment, label=substitution), colour="black", size=2.5, vjust=-1)
#p <- p + geom_text(aes(x=date, y=segment, label=substitution), vjust=subset(df$hj, df$lineage %in% c("Yam-2")), colour="black", size=3)
p1 <- p %+% subset(df, lineage %in% c("Vic"))
p2 <- p %+% subset(df, lineage %in% c("Yam"))
p3 <- p %+% subset(df, lineage %in% c("Yam-2"))
p4 <- p %+% subset(df, lineage %in% c("Yam-3"))
grid.arrange(p1, p2, p3, p4, p4, ncol=1, top="Trunk Substitutions")
#p