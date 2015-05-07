# Load data
if(!file.exists("data")){dir.create("data")}
install.packages("sqldf")
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/household_power_consumption.zip")
temp<-unzip("./data/household_power_consumption.zip", "household_power_consumption.txt", exdir="./data")
file<-"./data/household_power_consumption.txt"
householdData<-read.csv.sql(file, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", header=TRUE, sep=";")
unlink(temp)
datetimes<-as.POSIXct(strptime(paste(householdData$Date, householdData$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))
# Plot
par(mfrow=c(2,2))
with (householdData,{
  #1
  plot(x=datetimes, y=householdData$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  #2
  plot(x=datetimes, y=householdData$Voltage, type="l", ylab="Voltage", xlab="datetime")
  #3
  plot(x=datetimes, y=householdData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(x=datetimes, y=householdData$Sub_metering_2, col="red")
  lines(x=datetimes, y=householdData$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")
  #4
  plot(x=datetimes, y=householdData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
}
      )
# Export to PNG
png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
with (householdData,{
  #1
  plot(x=datetimes, y=householdData$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  #2
  plot(x=datetimes, y=householdData$Voltage, type="l", ylab="Voltage", xlab="datetime")
  #3
  plot(x=datetimes, y=householdData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
  lines(x=datetimes, y=householdData$Sub_metering_2, col="red")
  lines(x=datetimes, y=householdData$Sub_metering_3, col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"), bty="n")
  #4
  plot(x=datetimes, y=householdData$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
}
)
dev.off()