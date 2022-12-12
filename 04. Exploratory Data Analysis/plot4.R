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


#Plot 4
par(mfrow= c(2,2))
with(sub_data,{
  
  plot(sub_data$DateTime,sub_data$Global_active_power, 
       type='l',
       xlab="", ylab= "Global Active Power (kilowatts)")
  
  plot(sub_data$DateTime,sub_data$Voltage,type='l',xlab="datetime",ylab="Voltage")
  
  plot(sub_data$DateTime,sub_data$Sub_metering_1,type='l', col="black", xlab="", ylab = "Energy sub metering")
  lines(sub_data$DateTime,sub_data$Sub_metering_2,col="red")
  lines(sub_data$DateTime,sub_data$Sub_metering_3,col="blue")
  legend("topright", col = c("Black", "Red", "Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),bty="n", lwd = 1)
  
  plot(sub_data$DateTime,sub_data$Global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")
  
}
)

dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
