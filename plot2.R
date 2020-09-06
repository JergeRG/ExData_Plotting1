## Load table with its respective column names and data type
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Filter registers with dates 2007-02-01 and 2007-02-02
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Remove rows with missing values
data <- data[complete.cases(data),]

## Paste Date with the Time
data$Date <- paste(data$Date, data$Time)

## Change the Date formart to DateTime
data$Date <- as.POSIXct(strptime(data$Date,"%d/%m/%Y %H:%M:%S"))

## Rename Date Column to Datetime
names(data)[1] <- "DateTime"

## Remove Time Column
data <- data[,(names(data) != "Time")]

## Create Plot
plot(data$Global_active_power~data$DateTime, type = "l", ylab="Global Active Power (kilowatts)", xlab="")

## Save plot in  a file with png format
dev.copy(png,"plot2.png", width=480, height=480)

## Close device
dev.off()

