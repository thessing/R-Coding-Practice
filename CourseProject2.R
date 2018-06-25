# File   -: CourseProject2.R
# Author -: Tim Hessing
# Date   -: 29-May-2018
# Version-: 1.0
#
# Description-: explore the National Emissions Inventory database and see what it say about 
# fine particulate matter pollution in the United states over the 10-year period 1999-2008.
#
# Get the data
# This first line will likely take a few seconds. Be patient!
#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#
# Plot #1 Emissions Totals from All Sources as a function of Year
#
x <- tapply(NEI$Emissions, NEI$year, FUN=sum)

plot(as.numeric(names(x)), x, 
     xlab = "Year", 
     ylab = "Total Emissions (pm2.5 in tons)", 
     pch  = 19, 
     col  = "red",
     main = "United States")
#
# Plot #2 Emissions Totals from All Sources as a function of Year for Baltimore
#
y <- tapply(NEI$Emissions[NEI$fips=="24510"], NEI$year[NEI$fips=="24510"], FUN=sum)

plot(as.numeric(names(y)), y, 
     xlab = "Year", 
     ylab = "Total Emissions (pm2.5 in tons)", 
     pch  = 19, 
     col  = "blue",
     main = "Baltimore")
#
# Plot #3 Emissions Totals from All Sources as a function of Year and Type for Baltimore
#
z <- aggregate(     NEI$Emissions[NEI$fips == "24510"], 
               by = list(NEI$year[NEI$fips == "24510"], 
                         NEI$type[NEI$fips == "24510"]), sum)
ggplot(data = z, 
       mapping = aes(x = z$Group.1, 
                     y = z$x, 
                     color = z$Group.2) ) + 
  labs(x = "Year",
       y = "Total Emissions (pm2.5 in tons)",
       color = "Type",
       title = "Baltimore by Type") +
  geom_point()
#
# Coal & Vehicle Related sources
#
Coal     <- SCC[grep("Coal",     SCC$EI.Sector),]
CX       <- NEI[NEI$SCC %in% Coal$SCC,]

Vehicles <- SCC[grep("Vehicles", SCC$EI.Sector),]
VX       <- NEI[NEI$SCC %in% Vehicles$SCC,]

#
# Plot #4 Coal Combustion Sources
#
x1 <- tapply(CX$Emissions, CX$year, FUN=sum)

plot(as.numeric(names(x1)), x1, 
     xlab = "Year", 
     ylab = "Total Emissions (pm2.5 in tons)", 
     pch  = 19, 
     col  = "red",
     main = "United States - Coal Combustion Related Sources")
#
# Plot #5 Motor Vehicle Sources in Baltimore
#
y1 <- tapply(VX$Emissions[VX$fips=="24510"], VX$year[VX$fips=="24510"], FUN=sum)
y2 <- tapply(VX$Emissions[VX$fips=="06037"], VX$year[VX$fips=="06037"], FUN=sum)

plot(as.numeric(names(y1)), y1, 
     xlab = "Year", 
     ylab = "Total Emissions (pm2.5 in tons)", 
     pch  = 19, 
     col  = "blue",
     main = "Baltimore")
#
# SSC$Short.Name (or $SSC.Level.Four) contains ALL or Total as well as individual sources. 
# Sould seperate out the ALL & Total to find overall total per year to avoid double counting
#
# Merge with names
both <- merge(NEI, SCC, by="SCC")
#
# Eliminate non-needed colums and rename to simplify
#
both <- both[,c("fips","Pollutant","Emissions","type","year",
                "Short.Name","EI.Sector",
                "SCC.Level.One",
                "SCC.Level.Two",
                "SCC.Level.Three",
                "SCC.Level.Four")]

#
# Plot #4 again in a different way
#
CX2 <- both[grep("Coal",     both$EI.Sector),]
x2  <- tapply(CX2$Emissions, CX2$year, FUN=sum)

plot(as.numeric(names(x2)), x2, 
     xlab = "Year", 
     ylab = "Total Emissions (pm2.5 in tons)", 
     pch  = 19, 
     col  = "red",
     main = "United States - Coal Combustion Related Sources")
#
# Plot #6 Vehicle Emissions by Year for LA & Baltimore
#
VX2 <- both[grep("Vehicles", both$EI.Sector),]
VX3 <- VX2[(VX2$fips=="24510" | VX2$fips=="06037"),]

#
# Note Y3 could have been used with Plot #5 as well
#
Y3  <- aggregate(VX3$Emissions,  list(VX3$year, VX3$fips), FUN=sum)

ggplot(data = Y3, 
       mapping = aes(x = Y3$Group.1, 
                     y = Y3$x, 
                     color = Y3$Group.2) ) + 
  labs(x = "Year",
       y = "Total Emissions (pm2.5 in tons)",
       color = "City(fips)",
       title = "Vehicle Emission by City") +
  geom_point()
#
# End
#
