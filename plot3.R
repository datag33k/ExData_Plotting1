# Stacey Wransky
# Exploratory Data Analysis 011
# Project 1, Plot 3

# download the file if it does not exist
if !(file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.txt", method="curl")
  unzip("household_power_consumption.zip", overwrite = TRUE)
}

# read the file for manipulation/plotting
hdat <- read.csv("household_power_consumption.txt",sep=";",stringsAsFactors=FALSE,na.strings="?")

# subset data: only rows containing Date == 2/1/2007 and 2/2/2007 (m/d/Y)
dat <- hdat[hdat$Date %in% c("1/2/2007", "2/2/2007"), ]

# collapse date/time to one variable; convert to date/time object
dt <- strptime(paste(dat$Date,dat$Time),"%d/%m/%Y %H:%M:%S")
dat$Date <- as.POSIXct(dat$Date)
dat$Date <- dt

# truncate time column no longer needed
dat <- dat[,c(1,3:9)]

# build plot3
plot(dat$Date,dat[,6],ylab="Energy sub metering",type="l",xlab="")
lines(dat$Date,dat[,7],col="red")
lines(dat$Date,dat[,8],col="blue")
legend("topright",legend=names(dat[,6:8]),pch="_",col=c("black","red","blue"))

# print to PNG
dev.print(png, file="plot3.png", width=575, height=575, pointsize=10)

# close off device connection
dev.off(png)

 
