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
                 select=c(Global_active_power))

#Plot
plot(hist(tabAll$Global_active_power), 
              main = "Global Active Power",
              col="red",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()
