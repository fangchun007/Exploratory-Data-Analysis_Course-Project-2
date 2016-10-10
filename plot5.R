# Question 5.
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
head(NEI)

## Plot ##
# I consider the the ON-ROAD data as the emissions from motor vehicle sources. And we 
# will use dplyr package in the step of data preprocessing.

library(dplyr)
Bal_Road_year <- filter(NEI, fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))
Bal_Road_year # check the data

g <- ggplot(Bal_Road_year, aes(factor(year), Emissions)) # Building up in Layers
g1 <- g + geom_bar(stat = "identity", width = 0.6, color = "#CC9980", fill = "#85A3E0") 
# First Plot with Bar Layer
g2 <- g1 + labs(x = "Year", y = "PM2.5 emissions from motor vehicle sources (Tons)")
g3 <- g2 + labs(title = "PM2.5 emissions from motor vehicle sources in Baltimore City (1999–2008)")
# Modifying Labels
g3

dev.copy(png, file = "plot5.png")
dev.off()
