# Question 3.
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")
# SCC is not used in this question
Bal_NEI <- subset(NEI, fips == "24510")

# We will use dplyr package to help in data preprocessing

library(dplyr)
baltimore <- group_by(Bal_NEI, year, type) %>%
    summarise(Emissions = sum(Emissions))
baltimore # check the result

## Plot ##
library(ggplot2)
g <- ggplot(baltimore, aes(as.factor(year), Emissions, fill = type))  # Building Up in Layers
g + geom_bar(stat = "identity") # First Plot with Bar Layer
g + geom_bar(stat = "identity") + facet_grid(. ~ type) # Adding More Layers: Facets
g + geom_bar(stat = "identity") + facet_grid(. ~ type) + labs(x = "Year", y = "Total PM2.5 emissions (Tons)" )
    + labs(title = "PM2.5 emissions via different sources for Baltimore City (1999-2008)") # Modifying Labels

dev.copy(png, file = "plot3.png")  # save the png file
dev.off()


## Note ##
# 1. I tried to use the command geom_line() to plot,
#    g <- ggplot(baltimore, aes(year, Emissions, color = type)) + geom_line() 
#    The result picutre is continuous.  The x label and the continuous y value is unreasonable.
#    Then I seek the ??geom for help. 
