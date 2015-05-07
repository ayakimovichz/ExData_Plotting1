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
hist(householdData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
# Export to PNG
png(filename="plot1.png", width=480, height=480, units="px")
hist(householdData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()