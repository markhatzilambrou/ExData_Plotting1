# read needed libraries
library(dplyr)
# download and unzip the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./exdata-data-household_power_consumption.zip", method = "curl")
unzip("./data/exdata-data-household_power_consumption.zip", exdir = ".")
# read data from the unzipped and downloaded file
# Header row in file; all data read as character
columnClasses <- c("character","character","character","character","character","character","character","character","character")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = columnClasses)
# Filter only 2/1/2007-2/2/2007
data.f <- filter(data, Date == "1/2/2007" | Date == "2/2/2007")
# Make a POSIXlt time variable from the Dat and Time columns 
data.f$datetime <- strptime(paste(data.f$Date, data.f$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
# Make targetted plotting variables numeric
data.f$Sub_metering_1 <- as.numeric(data.f$Sub_metering_1)
data.f$Sub_metering_2 <- as.numeric(data.f$Sub_metering_2)
data.f$Sub_metering_3 <- as.numeric(data.f$Sub_metering_3)
data.f$Global_active_power <- as.numeric(data.f$Global_active_power)
data.f$Global_reactive_power <- as.numeric(data.f$Global_reactive_power)
data.f$Voltage <- as.numeric(data.f$Voltage)

# Open PNG device
png(filename="plot4.png", width = 480, height = 480)
# Prepare Plotting space for 2x2 plots
par(mfrow = c(2,2))
par(cex=0.8)
# Plot Line Graph of Global Active Power upper-left
plot(data.f$datetime, data.f$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
lines(data.f$datetime, data.f$Global_active_power)
# Plot Line Graph of Voltage upper-right
plot(data.f$datetime, data.f$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(data.f$datetime, data.f$Voltage)
# Plot Line Graph of Submetering lower-left
plot(data.f$datetime, data.f$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
lines(data.f$datetime, data.f$Sub_metering_1)
lines(data.f$datetime, data.f$Sub_metering_2, col = "red")
lines(data.f$datetime, data.f$Sub_metering_3, col = "blue")
legend("topright", lty=1, cex=1, bty="n", col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Plot Line Graph of Submetering lower-right
plot(data.f$datetime, data.f$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
lines(data.f$datetime, data.f$Global_reactive_power)
# Close PNG device
dev.off()