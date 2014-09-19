library(data.table)
library(ggplot2)
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

download.file(url, 'FNEI.zip')
unzip('FNEI.zip')

NEI <- data.table(readRDS('summarySCC_PM25.rds'))
NEI <- subset(NEI, fips == "24510")
NEI$type <- factor(NEI$type)
totals <- NEI[,list(sum=sum(Emissions)),by=list(year,type)]

png('plot3.png')
print(ggplot(totals, aes(x=year, y=sum, col=type)) + geom_line() + 
        labs(y = expression(PM[2.5] * " (tons)")) +
        labs(title = expression("Baltimore " * PM[2.5] * " by Type")))
dev.off()