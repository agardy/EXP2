library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")
pom <- grep("coal", SRC$EI.Sector, value = TRUE, ignore.case = TRUE)
SRC.pom <- subset(SRC, SRC$EI.Sector %in% pom, select = SCC)
NEI.pom <- subset(NEI, NEI$SCC %in% SRC.pom$SCC)
agg <- aggregate(NEI.pom$Emissions, list(type = NEI.pom$type, year = NEI.pom$year), sum)
plot <- ggplot(agg, aes(year, x)) +
     geom_smooth(size=2, method = "loess") +
	xlab("Year") +
	ylab("Emissions (Total Sum)")
print(plot)
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
