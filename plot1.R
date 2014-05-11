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

## """Code for plot 1"""

# create the PNG file
png(filename = 'plot1.png')

# make the plot for figure 1
hist(data_set$Global_active_power, main="Global Active Power", col="red", ylab="Frequency", xlab="Global Active Power(kilowatts)")

# close the PNG 
dev.off()

