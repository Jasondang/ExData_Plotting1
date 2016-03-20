#Read the data in a table
data <- read.table("./Projects/household_power_consumption.txt", header=TRUE, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Subset only the data within the required dates
dataSet <- subset(data, subset=(Date >="2007-02-01" & Date <= "2007-02-02"))

#Convert the data into numeric format
dataSet$Global_active_power <- as.numeric(as.character(dataSet$Global_active_power))

datetime <- paste(as.Date(dataSet$Date), dataSet$Time)
dataSet$Datetime <- as.POSIXct(datetime)

#Plot the graph
hist(dataSet$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()