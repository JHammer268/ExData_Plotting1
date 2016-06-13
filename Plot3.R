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

png(file="plot3.png")
with(power, plot(Sub_metering_1 ~ dateTime,
                 type="l",
                 ylab="Energy sub metering",
                 xlab=""
                 ))
legend(x="topright",c("Sub_metering_1",
                       "Sub_metering_2",
                       "Sub_metering_3"),
                   lty=(c(1,1,1)),
                   col=c("black","red","blue")
                   )
with(power, lines(Sub_metering_2 ~ dateTime,
                  col="red"
                  ))
with(power, lines(Sub_metering_3 ~ dateTime,
                  col="blue"
                  ))
legend(x="topright",
       c("Sub_metering_1",
         "Sub_metering_2",
         "Sub_metering_3"),
       lty=(c(1,1,1)),
       col=c("black","red","blue")
       )
dev.off()     