# Question 1.
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from
# all sources for each of the years 1999, 2002, 2005, and 2008.

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Check the structures ## 

head(NEI, n = 3)
head(SCC, n = 3)
summary(NEI$Emissions) # we found there is no NA values for Emission

## Plot ##

pm25_year <- with(NEI, tapply(Emissions, year, sum))
barplot(pm25_year / 10^6, 
    names.arg = names(pm25_year), 
    xlab = "Year", 
    ylab = "Total PM2.5 Emissions (10^6 tons)",
    main = "Total PM2.5 Emissions in US/Year")
dev.copy(png, file = "plot1.png")
dev.off()

## Note ##
# I tried to use function plot to finish the job, but it result with an ugly picture. So I gave up.
# plot(names(pm25_year), pm25_year / 10^6, type = "l", xlab = "Year", ylab = "Total PM2.5 Emissions")
