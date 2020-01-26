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
                 select=c(Date,Time,Global_active_power))


DateTime <- paste(as.character(tabAll$Date),tabAll$Time)
tabAll$DateTime <- as.POSIXct(strptime(DateTime,"%Y-%m-%d %H:%M:%S"))

#Plot
plot(tabAll$DateTime,tabAll$Global_active_power, 
              main = "Global Active Power", type="l",col="black",
              xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png")
dev.off()




# Calculating memory requirements
# 2,075,259 rows and 9 columns
N_bytes <- 2075259 * 9 *8
M_bytes <- N_bytes/2^20
M_bytes
#initial <- read.csv("household_power_consumption.txt",sep = ";",stringsAsFactors = FALSE,nrows=100)
#classes <- sapply(initial,class)

