library(data.table)
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

download.file(url, 'FNEI.zip')
unzip('FNEI.zip')

NEI <- data.table(readRDS('summarySCC_PM25.rds'))
totals <- NEI[,list(sum=sum(Emissions)),by=year]

png('plot1.png')
plot(totals, type='l', main='Total PM25 by Year', xaxt='n', yaxt='n', ylab='total pm25 (millions of tons)')
axis(side=1, at=totals$year)
axis(side=2, at=c(4e06, 5e06, 6e06, 7e06), labels=c('4', '5', '6', '7'))
dev.off()