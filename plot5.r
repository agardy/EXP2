library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")
pom <- grep("vehicle", SRC$EI.Sector, value = TRUE, ignore.case = TRUE)
SRC.pom <- subset(SRC, SRC$EI.Sector %in% pom, select = SCC)
baltimore <- subset(NEI, fips == "24510")
NEI.pom <- subset(baltimore, baltimore$SCC %in% SRC.pom$SCC)
agg <- aggregate(NEI.pom$Emissions, list(type = NEI.pom$type, year = NEI.pom$year), sum)
plot <- ggplot(agg, aes(year, x, colour = type)) +
     geom_smooth(size=2, method = "loess") +
	xlab("Year") +
	ylab("Emissions (Total Sum)")
print(plot)
dev.copy(png, file = "plot5.png", height = 480, width = 480)
dev.off()
