library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combustion_rel <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal_rel <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion_rel & coal_rel)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

dev.copy(png, file = "plot4.png", height = 480, width = 480)
ggp <- ggplot(combustionNEI, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission"))
print(ggp)
dev.off()
