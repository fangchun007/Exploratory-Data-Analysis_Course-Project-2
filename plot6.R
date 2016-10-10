# Question 6.
# Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which 
# city has seen greater changes over time in motor vehicle emissions?

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")

## Data preprocessing ##
# I consider the the ON-ROAD data as the emissions from motor vehicle sources. And we 
# will use dplyr package in the step of data preprocessing.

library(dplyr)
Bal_Road_year <- filter(NEI, fips == "24510" & type == "ON-ROAD") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))
Bal_Road_year$City <- rep("Baltimore City", 4)
Bal_Road_year # check the data

# Next, we get Los_Road_year data in a similar way.
Los_Road_year <- filter(NEI, fips == "06037" & type == "ON-ROAD") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))
Los_Road_year$City <- rep("Los Angeles", 4)
Los_Road_year # check the data

# combine Baltimore data and Los Angeles data
BL_Road_year <- rbind(Bal_Road_year, Los_Road_year)
BL_Road_year # check

## Plot ##
g <- ggplot(BL_Road_year, aes(factor(year), Emissions, fill = year))
g1 <- g + geom_bar(stat = "identity", width = 0.6)
g2 <- g1 + facet_grid(. ~ City)
g3 <- g2 + labs(x = "Year", y = "PM2.5 emissions from motor vehicle sources (Tons)")
g4 <- g3 + labs(title = "Total PM2.5 emissions from motor vehicle sources (Baltimore vs Los Angeles)")
g4

# save the plot
dev.copy(png, file = "plot6.png")
dev.off()


