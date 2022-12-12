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

#Plot 2 
par(mfrow=c(1,1))
plot(sub_data$DateTime,sub_data$Global_active_power, 
     type='l',
     xlab="", ylab= "Global Active Power (kilowatts)")

dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()