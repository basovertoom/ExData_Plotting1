# load in a part of the raw-data in to R
inload_data <- read.table("household_power_consumption.txt", nrows= 80000, sep=";", header = T) 

# chekc subset the relevant data for the two days
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

# download the subset
data_set <- inload_data[lines,]

# with class function below you can chech the classes of the different coloms
classes <- sapply(data_set, class)

# since some class are not set as numeric - set all relevant colums to numeric with following function

for(i in 3:9) {
	data_set[,i] <- as.numeric(as.character(data_set[,i]))
}

# create a new colom for Date + time combined
data_set$Date <- as.character(data_set$Date)
data_set$Time <- as.character(data_set$Time)
data_set$DateTime <- paste(data_set$Date, data_set$Time)
data_set$DateTime <- strptime(data_set$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Set the date colom as Date
data_set$Date <- as.Date(data_set$Date, format = "%d/%m/%Y")

# check for any missing value in the selected data_set - conclusion: no missing values
any(data_set[,3:9] =='?')


## """Code for plot 4"""

# create the PNG file
png(filename = 'plot4.png')

# make the plot for figure 4
par(mfrow = c(2,2))

#figure 1
with(data_set, plot(DateTime, Global_active_power, ylab='Global Active Power (kilowatts)', xlab='',type='l'))
#figure 2
with(data_set, plot(DateTime, Voltage, ylab='Voltage', xlab='datetime',type='l'))
#figure 3
with(data_set, plot(DateTime, Sub_metering_1, ylab='Energy sub metering', xlab='', type='n'))
lines(data_set$DateTime, data_set$Sub_metering_1, col='black')
lines(data_set$DateTime, data_set$Sub_metering_2, col='yellow')
lines(data_set$DateTime, data_set$Sub_metering_3, col='green')
legend("topright",cex=0.7, lty = 1, col = c("black", "yellow", "green"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#figure 4
with(data_set, plot(DateTime, Global_reactive_power, xlab='datetime',type='l'))

# close the PNG 
dev.off()

