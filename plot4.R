# Question 4.
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
