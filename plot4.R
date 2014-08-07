plot4 <- function(){
## Downloading and unzipping original data
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zipUrl,destfile="data.zip",method="curl")
unzip("data.zip")
## Importing original data, then subsetting by relevant dates, then tidying dataset
thedata <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("character","character","numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings="?")
thedata$DateTime <- strptime(paste(thedata$Date,thedata$Time), "%d/%m/%Y %H:%M:%S")
thedata <- subset(thedata,as.Date(DateTime) > as.Date("2007-01-31") & as.Date(DateTime) < as.Date("2007-02-03"))
thedata$Date <- NULL
thedata$Time <- NULL
row.names(thedata) <- NULL
## Selecting PNG graphics device then specifying parameters for plots array
png(file="plot4.png")
Sys.setlocale("LC_TIME", "C") # To be sure weekdays will be in English
par(mfrow=c(2,2),mar=c(4,4,4,2),oma=c(1,0,0,0))
## Printing plots array
plot(thedata$DateTime,thedata$Global_active_power, type="l", xlab="", ylab="Global Active Power") # Plot 1
plot(thedata$DateTime,thedata$Voltage, type="l", xlab="datetime", ylab="Voltage") # Plot 2
plot(thedata$DateTime,thedata$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering") # Plot 3, creating plot frame
lines(thedata$DateTime,thedata$Sub_metering_1,col="black") # Plot 3, plotting line 1, and 2, then 3
lines(thedata$DateTime,thedata$Sub_metering_2,col="red")
lines(thedata$DateTime,thedata$Sub_metering_3,col="purple")
legend("topright",lty=1,col=c("black","red","purple"), bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) # Plot 3, creating legend
plot(thedata$DateTime,thedata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power") # Plot 4
dev.off()
}