#Read the data in a table
data <- read.table("./Projects/household_power_consumption.txt", header=TRUE, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset only the data within the required dates
dataSet <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02"))

#Convert the data into numeric format 
dataSet$Global_active_power <- as.numeric(as.character(dataSet$Global_active_power))

dataSet$Voltage <- as.numeric(as.character(dataSet$Voltage))

dataSet$Sub_metering_1 <- as.numeric(as.character(dataSet$Sub_metering_1))
dataSet$Sub_metering_2 <- as.numeric(as.character(dataSet$Sub_metering_2))
dataSet$Sub_metering_3 <- as.numeric(as.character(dataSet$Sub_metering_3))

dataSet$Global_reactive_power <- as.numeric(as.character(dataSet$Global_reactive_power))

datetime <- paste(as.Date(dataSet$Date), dataSet$Time)
dataSet$Datetime <- as.POSIXct(datetime)

#Format margins of the graph window into 2x2 matrix
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


with(dataSet, {
  #Plot first graph
  plot(Global_active_power~Datetime, type="l",xlab="", 
     ylab="Global Active Power")
  #Plot second graph
  plot(Voltage~Datetime, type="l", 
     xlab="datetime", ylab="Voltage")
  #Plot third graph
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~Datetime,col='Red')
lines(Sub_metering_3~Datetime,col='Blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=2, lwd=2,bty="n", cex=.5, col=c("black", "red", "blue"))
  #Plot last graph
  plot(Global_reactive_power~Datetime, type="l", 
     xlab="datetime",ylab="Global_reactive_Power")
})

# Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()