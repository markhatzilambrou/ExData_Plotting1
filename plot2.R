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
data.f$Global_active_power <- as.numeric(data.f$Global_active_power)
# Open PNG device
png(filename="plot2.png", width = 480, height = 480)
# Plot Line Graph
plot(data.f$datetime, data.f$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
lines(data.f$datetime, data.f$Global_active_power)
# Close PNG device
dev.off()