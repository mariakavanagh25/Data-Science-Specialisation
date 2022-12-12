## Loading the data

# Load the data set into R, convert data variable to date/Time class

path <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
raw_data <- read.table(path, sep=';', header=TRUE, na.strings='?')
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")

# Subset to only 2007-02-01 and 2007-02-02
sub_data <- subset(raw_data, raw_data$Date>=as.Date("2007-02-01") & raw_data$Date <= as.Date("2007-02-02"))

# Create DateTime variables (in date/time class) (needed for plot 2)
sub_data$DateTime <- strptime(paste(sub_data$Date, sub_data$Time), "%Y-%m-%d %H:%M:%S")

## Making Plots

#Plot 3
par(mfrow=c(1,1))
with(sub_data, {
  plot(sub_data$DateTime,sub_data$Sub_metering_1,type='l', col="black", xlab="", ylab = "Energy sub metering")
  lines(sub_data$DateTime,sub_data$Sub_metering_2,col="red")
  lines(sub_data$DateTime,sub_data$Sub_metering_3,col="blue")
  legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)
} )

dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()
