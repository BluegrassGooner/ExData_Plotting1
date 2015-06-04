#Load data for Plot1
data <- read.csv("data.csv")

hist(data$Global_active_power, col = "red", breaks = 18, xlim = c(0,6),
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()
