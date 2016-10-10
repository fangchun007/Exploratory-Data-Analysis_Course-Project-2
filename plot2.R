# Question 2.
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 ==
# "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering 
# this question.

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Check the structures ## 

head(NEI, n = 3)
head(SCC, n = 3)
