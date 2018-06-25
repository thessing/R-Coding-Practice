# File   -: dataPlotting.R
# Author -: Tim Hessing
# Date   -: 09-May-2018
# Version-: 1.0
#
# Description-: assignment to read in data and make plots
#
# Load Libraries
# 
library("dplyr", lib.loc="~/R/win-library/3.4")
library("ggplot2", lib.loc="~/R/win-library/3.4")

#
# Define data file name/location
#
dataFile <- 
  "C:/Users/hessit1/Desktop/Data Science/R Code/exdata_data_household_power_consumption/household_power_consumption.txt"

#
# Read in data and filter on dates needed.
#
hhPower<- with(hhPower <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE ), 
               subset(hhPower,Date == "1/2/2007" | Date == "2/2/2007") )
#
# Convert Data & Time to a Date Time
#
hhPower    <- mutate(hhPower, dt = paste(hhPower$Date, hhPower$Time) )
hhPower$dt <- strptime(hhPower$dt, "%d/%m/%Y %H:%M:%S")

par(mfrow=c(1,1))
#
# Open 480x480 png file
#
png(filename = "plot1.png", width = 480, height = 480)

#
# Create Plot 1
#
hist(as.numeric(hhPower$Global_active_power), col="red", 
     xlab = "Global Active Power (kilowats)", 
     ylab = "Frequency", 
     main = "Global Active Power")

#
# Close png file
#
dev.off()

#
# Open 480x480 png file
#
png(filename = "plot2.png", width = 480, height = 480)

#
# Create Plot 2
#
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Global_active_power, 
     ylab = "Global Active Power (kilowats)", 
     xlab = "", type = "l")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
     )
#
# Close png file
#
dev.off()

#
# Open 480x480 png file
#
png(filename = "plot3.png", width = 480, height = 480)

#
# Create Plot 3
#
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Sub_metering_1, 
     ylab = "Energy sub metering (kilowats)", 
     xlab = "", type = "l", col = "black")
lines(as.numeric(hhPower$dt), hhPower$Sub_metering_2, col ="red")
lines(as.numeric(hhPower$dt), hhPower$Sub_metering_3, col ="blue")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
)
#
# Add Legend
#
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

#
# Close png file
#
dev.off()

#
# Open 480x480 png file
#
png(filename = "plot4.png", width = 480, height = 480)

#
# Create Plot 4
#
# Need 4 plots
#
par(mfrow=c(2,2))
#
#-----1-----
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Global_active_power, 
     ylab = "Global Active Power", 
     xlab = "", type = "l")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
)

#-----2-----
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Voltage, 
     ylab = "Voltage", 
     xlab = "datetime", type = "l")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
)
#-----3-----
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Sub_metering_1, 
     ylab = "Energy sub metering", 
     xlab = "", type = "l", col = "black")
lines(as.numeric(hhPower$dt), hhPower$Sub_metering_2, col ="red")
lines(as.numeric(hhPower$dt), hhPower$Sub_metering_3, col ="blue")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
)
#
# Add Legend
#
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

#-----4-----
# turn off x-axis
#
par(xaxt="n")
#
# plot data
#
plot(as.numeric(hhPower$dt), hhPower$Global_reactive_power, 
     ylab = "Global_reactive_power", 
     xlab = "datetime", type = "l")
#
# turn on x-axis
#
par(xaxt="s")
#
# Draw x-axis with weekday labels
#
daysec <- 60*60*24
axis(1, at=c(as.numeric(hhPower$dt[1]), 
             as.numeric(hhPower$dt[1440]), 
             as.numeric(hhPower$dt[2880]) ),
     labels = c(format(hhPower$dt[1],           "%a"), 
                format(hhPower$dt[1440]+daysec, "%a"), 
                format(hhPower$dt[2880]+daysec, "%a") )
)
#
# Close png file
#
dev.off()

