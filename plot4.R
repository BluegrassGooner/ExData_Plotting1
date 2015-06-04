#Load necessary libraries
library(sqldf)

if(!file.exists("./data")){
  dir.create("./data")
}

#Download 'Individual household electric power consumption Data Set'
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")

#Unzip
unzip("./data/household_power_consumption.zip", exdir = "./data")
unlink("./data/household_power_consumption.zip")

#Read only rows where the date is '2/1/2007' or '2/2/2007'
power.df <- read.csv.sql("./data/household_power_consumption.txt", sep = ";", sql = "select * from file where Date in ('2/1/2007','2/2/2007')")
#Create datetime column in the dataframe
datetime <- strptime(paste(power.df$Date,power.df$Time), "%m/%d/%Y %H:%M:%S")
power.df <- cbind(datetime,power.df[,3:9])

#Set up par
par(mfcol = c(2,2), mar = c(4,4,2,1))

#Create first plot
plot(power.df$datetime,power.df$Global_active_power, type = "n", ylab = "Global Active Power", xlab = "")
lines(power.df$datetime,power.df$Global_active_power)

#Create second plot
#Plot Scatterplot
plot(power.df$datetime,power.df$Sub_metering_3, ylim = c(0,38),type = 'l', col = "blue", xlab = "", ylab = "Energy sub metering")
points(power.df$datetime,power.df$Sub_metering_1, type = 'l', lwd = 2)
points(power.df$datetime,power.df$Sub_metering_2, type = 'l', col = 'red')

#Add legend
legend("topright", bty = 'n',legend = names(power.df[6:8]), lty = 1, col = c('black', 'red', 'blue'))

#Create third plot
plot(power.df$datetime,power.df$Voltage, type = 'l', ylim = c(231,248), xlab = "datetime", ylab = "Voltage")

#Create forth plot
with(power.df, plot(datetime, Global_reactive_power, type = "l"))

#Create PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

#Copy PNG file to ExData_Plotting1 repo
file.copy(c("plot4.png","plot4.R"), "ExData_Plotting1/")

#Clean up
closeAllConnections()
rm(list = ls())
file.remove("./data/household_power_consumption.txt")

