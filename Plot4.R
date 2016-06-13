library(lubridate)

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL, destfile = "power.zip")
unzip("power.zip")
power <- read.table("household_power_consumption.txt",sep=";", na.strings="?", header=TRUE, stringsAsFactors=FALSE)

power$Date <- dmy(power$Date)

power$Time <- hms(power$Time)

power <- subset(power, Date == "2007-02-01" | Date == "2007-02-02")

dateTime <- power$Date + power$Time
power <- cbind(dateTime, power)

png(file="plot4.png")

par(mfrow = c(2,2))

## plot 1: Upper Left
with(power, plot(Global_active_power~dateTime, 
                 type = "l",
                 ylab = "Global Active Power",
                 xlab=""
                 ))

## Plot 2: Upper Right
with(power, plot(Voltage~dateTime, 
                 type = "l",
                 ylab = "Voltage",
                 xlab="dateTime"
                 ))
## Plot3: Lower Left
with(power, plot(Sub_metering_1 ~ dateTime,
                 type="l",
                 ylab="Energy sub metering",
                 xlab=""
                 ))
legend(x="topright",c("Sub_metering_1",
                       "Sub_metering_2",
                       "Sub_metering_3"),
                   lty=(c(1,1,1)),
                   col=c("black","red","blue"),
                   cex=0.75,
                   bty="n"
                   )
with(power, lines(Sub_metering_2 ~ dateTime,
                  col="red"
                  ))
with(power, lines(Sub_metering_3 ~ dateTime,
                  col="blue"
                  ))
## Plot4: Lower Right
with(power, plot(Global_reactive_power~dateTime, 
                 type = "l",
                 ylab = "Global reactive Power",
                 ))

dev.off()     