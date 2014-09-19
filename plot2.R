library(data.table)
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

download.file(url, 'FNEI.zip')
unzip('FNEI.zip')

NEI <- data.table(readRDS('summarySCC_PM25.rds'))
NEI <- subset(NEI, fips == "24510")
totals <- NEI[,list(sum=sum(Emissions)),by=year]

png('plot2.png')
plot(totals, type='l', main='Total PM25 by Year in Baltimore', xaxt='n', ylab='total pm25 (tons)')
axis(side=1, at=totals$year)
dev.off()