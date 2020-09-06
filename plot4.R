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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power~DateTime, type = "l", ylab="Global Active Power", xlab="")
    
    plot(Voltage~DateTime, type = "l", ylab="Voltage", xlab="datetime")
    
    plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.60)
    
    plot(Global_reactive_power~DateTime, type = "l", ylab="Global_reactive_power", xlab="datetime")
})

## Save plot in  a file with png format
dev.copy(png,"plot4.png", width=480, height=480)

## Close device
dev.off()