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

#Plot Scatterplot
plot(power.df$datetime,power.df$Sub_metering_3, type = 'l')
points(power.df$datetime,power.df$Sub_metering_1, type = 'l')
points(power.df$datetime,power.df$Sub_metering_2, type = 'l')

