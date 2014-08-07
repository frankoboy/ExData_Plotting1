plot3 <- function(){
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
## Selecting PNG graphics device then outputting plot 3 in it
png(file="plot3.png")
Sys.setlocale("LC_TIME", "C") # To be sure weekdays will be in English
plot(thedata$DateTime,thedata$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering") # Creating plot frame
lines(thedata$DateTime,thedata$Sub_metering_1,col="black") # Plotting line 1, and 2, then 3
lines(thedata$DateTime,thedata$Sub_metering_2,col="red")
lines(thedata$DateTime,thedata$Sub_metering_3,col="purple")
legend("topright",lty=1,col=c("black","red","purple"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) # Creating legend
dev.off()
}