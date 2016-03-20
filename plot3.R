#Read the data in a table
data <- read.table("./Projects/household_power_consumption.txt", header=TRUE, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset only the data within the required dates
dataSet <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02"))

dataSet$Sub_metering_1 <- as.numeric(as.character(dataSet$Sub_metering_1))
dataSet$Sub_metering_2 <- as.numeric(as.character(dataSet$Sub_metering_2))
dataSet$Sub_metering_3 <- as.numeric(as.character(dataSet$Sub_metering_3))

datetime <- paste(as.Date(dataSet$Date), dataSet$Time)
dataSet$Datetime <- as.POSIXct(datetime)

#Plot the graph
with(dataSet, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

#Create legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()