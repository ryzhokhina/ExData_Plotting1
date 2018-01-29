## Prepare data
####################################################################

# download data
zipFileName<-"dataset.zip"
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(zipFileName)){
  download.file(url,zipFileName, mode = "wb") 
}
# unpack zip
fileName<- "household_power_consumption.txt"
if(!file.exists(fileName))
{
  unzip(zipFileName) 
}
# read data
data <- read.table(fileName, header = TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

f<-subset(data, as.Date(data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(data$Date, format = "%d/%m/%Y")<= as.Date("2007-02-02"))

if (!"plyr" %in% installed.packages()) {
  install.packages("plyr")
}
library(plyr)
f<-mutate(f, DateTimeCol = strptime(paste(f$Date, f$Time, sep=" "),"%d/%m/%Y %H:%M:%S"))

#plot3

par(mfrow=c(1,1))

plot( f$DateTimeCol, f$Sub_metering_1,type= "n",
      xlab = "", ylab="Energy sub metering", main = "")

lines( f$DateTimeCol, f$Sub_metering_1,col= "black")
lines( f$DateTimeCol, f$Sub_metering_2,col= "red")
lines( f$DateTimeCol, f$Sub_metering_3,col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=c(1,1,1))

dev.copy(png, file = "plot3.png",  width= 480, height=480)
dev.off()
