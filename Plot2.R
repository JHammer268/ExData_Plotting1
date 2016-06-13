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

png(file="plot2.png")
with(power, plot(Global_active_power~dateTime, 
                 type = "l",
                 ylab = "Global Active Power (kilowatts)",
                 xlab=""
                 ))
dev.off()     