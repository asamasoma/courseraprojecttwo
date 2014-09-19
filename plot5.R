library(data.table)
library(ggplot2)
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

download.file(url, 'FNEI.zip')
unzip('FNEI.zip')

NEI <- data.table(readRDS('summarySCC_PM25.rds'))
SCC <- data.table(readRDS('Source_Classification_Code.rds'))
codes <- droplevels(SCC$SCC[grep('[Vv]ehicle', SCC$EI.Sector)])
NEI <- subset(NEI, fips == "24510")
NEI <- subset(NEI, SCC %in% codes)
totals <- NEI[,list(sum=sum(Emissions)),by=list(year)]

png('plot5.png')
print(ggplot(totals, aes(x=year, y=sum)) + geom_line() + 
        labs(y = expression(PM[2.5] * " (tons)")) +
        labs(title = "Baltimore City Motor Vehicle Emissions"))
dev.off()