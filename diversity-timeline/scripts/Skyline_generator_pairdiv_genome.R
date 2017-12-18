## Output pdf
pdf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/pdfs/global_fluB.genome.pairdivs.4.pdf',paper='a4') ## output pdf

## Page layout
#layout(matrix(c(1,2,3),3,1,byrow=TRUE), height=c(0.30,0.10,0.50), width=1)
#par(xaxs = "i", yaxs = "i") ##makes axes touch at 0,0
#oldpar <- par(las=1, mar=c(0,5,0,5), oma=c(1.0,0.5,3.5,0.5), cex=0.75, cex.lab=0.75)

par(xaxs = "i", yaxs = "i") ##makes axes touch at 0,0
#oldpar <- par(mfrow=c(3,1), mai=c(0.3,0.05,0.1,0.1), oma=c(3,5.25,2,0.5))
#oldpar <- par(mfrow=c(4,2), mai=c(0.3,0.5,0.5,0.5), oma=c(1,1,1,1))
oldpar <- par(mfrow=c(4,2), mai=c(0.05,0.05,0.05,0.05), oma=c(4,2,4,2))

## par(mfrow=2:1, oma= c(2,2,2,2), mar=c(0,2,2,2))

options(scipen=1)

## Colours
lgrey <- rgb(211, 211, 211, alpha=65, maxColorValue=255)
c_PB2 <- rgb(92, 24, 92, alpha=175, maxColorValue=255)
c_PB1 <- rgb(172, 114, 168, alpha=175, maxColorValue=255)
c_PA <- rgb(133, 38, 128, alpha=175, maxColorValue=255)
c_HA <- rgb(9, 74, 137, alpha=175, maxColorValue=255)
c_NP <- rgb(181, 30, 38, alpha=175, maxColorValue=255)
c_NA <- rgb(250, 184, 14, alpha=175, maxColorValue=255)
c_M1 <- rgb(238, 126, 28, alpha=175, maxColorValue=255)
c_NS1 <- rgb(137, 162, 76, alpha=175, maxColorValue=255)

## Axis values
year_beg <- 2002.0
year_end <- 2015.0
year_int <- 1

val_min <- 0
val_max <- 25
val_int <- 5

for (region in c("usa", "europe", "chinasea", "oceania")){
	for (lineage in c("vic", "yam")){
		## Input files from pact
		raw_PB2.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/PB2/%s/%s/out.skylines', lineage, region), header=T)
		raw_PB1.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/PB1/%s/%s/out.skylines', lineage, region), header=T)
		raw_PA.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/PA/%s/%s/out.skylines', lineage, region), header=T)
		raw_HA.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/HA/%s/%s/out.skylines', lineage, region), header=T)
		raw_NA.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/NA/%s/%s/out.skylines', lineage, region), header=T)
		raw_M1.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/M1/%s/%s/out.skylines', lineage, region), header=T)
		raw_NS1.data <- read.table(sprintf('/Users/pl6/Desktop/Projects/2-FluB/Global_diversity/PairDiv/NS1/%s/%s/out.skylines', lineage, region), header=T)

		#### DATA/PLOTS ####
		## PB2
		#plot(raw_PB2.data$time, raw_PB2.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PB2, pch=19, xlab="", ylab="", panel.first=c(abline(v=seq(year_beg+0.333, year_end+0.833,by=0.5), lty="22", col=lgrey))) 
		plot(raw_PB2.data$time, raw_PB2.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PB2, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_PB2.data$time, raw_PB2.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PB2, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_PB2.data$time, raw_PB2.data$lower, raw_PB2.data$time, raw_PB2.data$upper, length=0.0001, angle=90, code=3,col=c_PB2)

		##PB1
		par(new=TRUE)
		plot(raw_PB1.data$time, raw_PB1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PB1, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_PB1.data$time, raw_PB1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PB1, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_PB1.data$time, raw_PB1.data$lower, raw_PB1.data$time, raw_PB1.data$upper, length=0.0001, angle=90, code=3,col=c_PB1)

		##PA
		par(new=TRUE)
		plot(raw_PA.data$time, raw_PA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PA, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_PA.data$time, raw_PA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_PA, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_PA.data$time, raw_PA.data$lower, raw_PA.data$time, raw_PA.data$upper, length=0.0001, angle=90, code=3,col=c_PA)

		##HA
		par(new=TRUE)
		plot(raw_HA.data$time, raw_HA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_HA, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_HA.data$time, raw_HA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_HA, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_HA.data$time, raw_HA.data$lower, raw_HA.data$time, raw_HA.data$upper, length=0.0001, angle=90, code=3,col=c_HA)

		##NA
		par(new=TRUE)
		plot(raw_NA.data$time, raw_NA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_NA, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_NA.data$time, raw_NA.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_NA, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_NA.data$time, raw_NA.data$lower, raw_NA.data$time, raw_NA.data$upper, length=0.0001, angle=90, code=3,col=c_NA)

		##M1
		par(new=TRUE)
		plot(raw_M1.data$time, raw_M1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_M1, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_M1.data$time, raw_M1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_M1, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_M1.data$time, raw_M1.data$lower, raw_M1.data$time, raw_M1.data$upper, length=0.0001, angle=90, code=3,col=c_M1)

		##NS1
		par(new=TRUE)
		plot(raw_NS1.data$time, raw_NS1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_NS1, pch=19, xlab="", ylab="") 
		par(new=TRUE)
		plot(raw_NS1.data$time, raw_NS1.data$mean, xlim=c(year_beg, year_end), ylim=c(val_min, val_max), axes=F, col=c_NS1, type="l", lwd=2, xlab="", ylab="") 
		arrows(raw_NS1.data$time, raw_NS1.data$lower, raw_NS1.data$time, raw_NS1.data$upper, length=0.0001, angle=90, code=3,col=c_NS1)

		#### END DATA/PLOTS #####

		## Axis labels
		if (lineage=='vic'){
			axis(side=2, at=c(v=seq(val_min, val_max, by=val_int)), las=1, lwd=0.5)
		}
		if (region=='oceania'){
			axis(side=1, at=c(v=seq(year_beg, year_end, by=year_int)), lwd=0.5)
		}
		
		#mtext("Mean pairwise genetic diversity (years)", side=2, line=3, las=0, cex=0.75)
		#mtext("Time", side=1, line=3, cex=0.75)
		#mtext(sprintf("%s %s", lineage, region), line=0.5, cex=0.9, adj=0, side=3)

		## Additional formatting
		box(lwd=0.5)
	}
}
par(oldpar)  
dev.off()