## initialize file names and constraining date variables
zipFileName     <- "exdata-data-household_power_consumption.zip"
sourceLocation  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
plotFileName    <- "plot3.png"
dataFileName    <- "household_power_consumption.txt"
date1           <- as.Date("2007-02-01","%Y-%m-%d")
date2           <- as.Date("2007-02-02","%Y-%m-%d")

## download source zip file if it doesn't already exist
if (!file.exists(zipFileName))
{
    download.file(sourceLocation,
                  destfile=zipFileName,
                  quiet=TRUE,
                  mode="wb")
}

## Unzip data file if it doesn't already exist
if (!file.exists(dataFileName))
{
    unzip(zipFileName,overwrite=FALSE)
}

## read in entire data file
data <- read.csv(dataFileName,
                 sep=";",
                 header=TRUE,
                 na.strings=c("?"),
                 as.is=c(TRUE))

## Subset data to include only rows within our date parameters
data <- data[as.Date(data$Date,"%d/%m/%Y") == date1 |
                 as.Date(data$Date,"%d/%m/%Y") == date2,]

## Create a new vector containing combined date/time value
data$Date <- as.Date(data$Date,"%d/%m/%Y")
dateTime  <- as.POSIXct(paste(data$Date, data$Time), 
                        format="%Y-%m-%d %H:%M:%S")

## open PNG device
png(file = plotFileName, 
    bg = "transparent",
    height=480,
    width=480)

##------------------------------------------------------
## build plot as specified in assignment for Plot 3
##------------------------------------------------------
plot(dateTime,
     data$Sub_metering_1,
     type="l",
     ylim=c(min(data$Sub_metering_1),
            max(data$Sub_metering_1) ),
     ylab="Energy sub metering",
     xlab="")

par(new=TRUE)
plot(dateTime,
     data$Sub_metering_2,
     type="l",
     axes=FALSE,
     xlab="",
     ylab="",
     col="red",
     ylim=c(min(data$Sub_metering_1),
            max(data$Sub_metering_1) ) ) 

par(new=TRUE)
plot(dateTime,
     data$Sub_metering_3,
     type="l",
     axes=FALSE,
     xlab="",
     ylab="",
     col="blue",
     ylim=c(min(data$Sub_metering_1),
            max(data$Sub_metering_1) ) ) 

legend("topright",
       c("sub_metering_1","sub_metering_2","sub_metering_3"),
       lty=c(1,1),
       lwd=c(2,2,2),
       col=c("black","red","blue"))

dev.off()
