library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
baltimore <- subset(NEI, fips == "24510")
agg <- aggregate(baltimore$Emissions, list(type = baltimore$type, year = baltimore$year), sum)
plot <- ggplot(agg, aes(year, x, colour = type)) +
     geom_smooth(size=2, method = "loess") +
	xlab("Year") +
	ylab("Emissions (Total Sum)")
print(plot)
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
