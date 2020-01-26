#Download file and unzip
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./household_power_consumption.zip",method = "curl")
dateDownloaded <- date()
unzip("./household_power_consumption.zip") #save unzipped files to local directory

#read data
classes <- c(rep("character",2),rep("numeric",7))
tabAll <- read.csv("household_power_consumption.txt", header = TRUE,sep = ";",
                   comment.char="", na.strings="?",colClasses=classes,
                   nrows=2075260)

#Convert to proper Data/Time format; Select data column
tabAll$Date <- as.Date(tabAll$Date,"%d/%m/%Y")
tabAll <- subset(tabAll,Date=="2007-02-01" | Date=="2007-02-02")

DateTime <- paste(as.character(tabAll$Date),tabAll$Time)
tabAll$DateTime <- as.POSIXct(strptime(DateTime,"%Y-%m-%d %H:%M:%S"))

#Plot
op <- par(no.readonly = TRUE) # the whole list of settable par's.

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

#1
plot(tabAll$DateTime,tabAll$Global_active_power, 
     main = "", type="l",col="black",
     xlab="",ylab="Global Active Power")

#2
plot(tabAll$DateTime,tabAll$Voltage, 
     main = "", type="l",col="black",
     xlab="datetime",ylab="Voltage")

#3
plot(tabAll$DateTime,tabAll$Sub_metering_1,type="l",
     col="black",xlab="",ylab="Energy sub metering")
lines(tabAll$DateTime,tabAll$Sub_metering_2,col="red")
lines(tabAll$DateTime,tabAll$Sub_metering_3,col="blue")
leg.txt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
legend("topright",bty="n",leg.txt,lty=1,cex=.7,col=c("black","red","blue"))

#4     
plot(tabAll$DateTime,tabAll$Global_reactive_power, 
              type="l",col="black",
              xlab="datetime",ylab="Global_reactive_power")

dev.off()
## reset par:
par(op)

