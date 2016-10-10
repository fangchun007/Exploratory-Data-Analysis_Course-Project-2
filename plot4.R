# Question 4.
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

## Load data ##
# make sure the files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are
# under the work directory. Otherwise, use Misc (for Mac) or setwd() to reset the
# current work directory.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Check the data NEI and SCC
head(NEI, n = 3)
head(SCC)
str(SCC)

## Data preprocessing ##
# The idea is first get the SCC$SCC set who has relation with coal combustion. Then
# one can filter the data NEI according to it and split the result subset of NEI according
# to variable NEI$year.
# Frankly, I met problems in finding the relevant SCC$SCC. Basically, I think we need to 
# check meanings of each variable in data SCC. Here, however, I just used the command 
# str(SCC) and head(SCC) to get a feeling that whether a variable of SCC can contain 
# the key words coal combustion. Simply put, if the values of variables SCC$Short.Name, 
# SCC$EI.Sector, SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, or 
# SCC$SCC.Level.Four, Then I will collect the corresponding SCC$SCC.

coal1 <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
coal2 <- grep("coal", SCC$EI.Sector, ignore.case = TRUE)
# coal3 <- with(SCC, grep("coal", SCC.Level.One, ignore.case = TRUE))
# coal4 <- with(SCC, grep("coal", SCC.Level.Two, ignore.case = TRUE))
# I delete these two vectors, because there results are integer(0). It will cause mistake
# when I produce coal_related.
coal5 <- grep("coal", SCC$SCC.Level.Three, ignore.case = TRUE)
coal6 <- grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
coal_related <- unique(c(coal1, coal2, coal5, coal6))
SCC_coal <- SCC[coal_related, ]
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC, ]
dim(NEI_coal) # check 

## Plot ##

NEI_coal_year <- data.frame(with(NEI_coal, tapply(Emissions, year, sum)))

g <- ggplot(NEI_coal_year, aes(rownames(NEI_coal_year), NEI_coal_year / 10^5)) # Building up in layers
g1 <- g + geom_bar(stat = "identity", width = 0.6, color = "#CC9980", fill = "#85A3E0") # First plot with Bar Layer
g2 <- g1 + labs(x = "Year", y = "Total coal related PM2.5 Emissions (10^5 Tons)") # Modifying Labels
g3 <- g2 + labs(title = "Total PM2.5 emissions from coal combustion-related sources in US from 1999–2008")

dev.copy(png, file = "plot4.png") # save the plot
dev.off()











