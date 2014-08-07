plot2 <- function(){
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
## Selecting PNG graphics device then outputting plot 2 in it
png(file="plot2.png")
Sys.setlocale("LC_TIME", "C") # To be sure weekdays will be in English
plot(thedata$DateTime,thedata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
}