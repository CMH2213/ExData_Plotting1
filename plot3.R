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
tabAll <- subset(tabAll,Date=="2007-02-01" | Date=="2007-02-02", 
                 select=c(Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3))


DateTime <- paste(as.character(tabAll$Date),tabAll$Time)
tabAll$DateTime <- as.POSIXct(strptime(DateTime,"%Y-%m-%d %H:%M:%S"))

#Plot
plot(tabAll$DateTime,tabAll$Sub_metering_1, type="l",col="black",
              xlab="",ylab="Energy sub metering")
lines(tabAll$DateTime,tabAll$Sub_metering_2,col="red")
lines(tabAll$DateTime,tabAll$Sub_metering_3,col="blue")
leg.txt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3") 
legend("topright",leg.txt,lty=1, cex=.7,col=c("black","red","blue"))


dev.copy(png,file="plot3.png")
dev.off()
