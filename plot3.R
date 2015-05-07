# Load data
if(!file.exists("data")){dir.create("data")}
install.packages("sqldf")
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/household_power_consumption.zip")
temp<-unzip("./data/household_power_consumption.zip", "household_power_consumption.txt", exdir="./data")
file<-"./data/household_power_consumption.txt"
householdData<-read.csv.sql(file, sql="select * from file where Date='1/2/2007' or Date='2/2/2007'", header=TRUE, sep=";")
unlink(temp)
# Plot
datetimes<-as.POSIXct(strptime(paste(householdData$Date, householdData$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))
plot(x=datetimes, y=householdData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(x=datetimes, y=householdData$Sub_metering_2, col="red")
lines(x=datetimes, y=householdData$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
# Export to PNG
png(filename="plot3.png", width=480, height=480, units="px")
plot(x=datetimes, y=householdData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(x=datetimes, y=householdData$Sub_metering_2, col="red")
lines(x=datetimes, y=householdData$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()