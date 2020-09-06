## Load table with its respective column names and data type
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Filter registers with dates 2007-02-01 and 2007-02-02
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Remove rows with missing values
data <- data[complete.cases(data),]

## Create the histogram
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save histogram in  a file with png format
dev.copy(png,"plot1.png", width=480, height=480)

## Close device
dev.off()