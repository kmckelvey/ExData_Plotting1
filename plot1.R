## initialize file names and constraining date variables
zipFileName     <- "exdata-data-household_power_consumption.zip"
sourceLocation  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFileName    <- "household_power_consumption.txt"
plotFileName    <- "plot1.png"
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

## open PNG device
png(file = plotFileName, 
    bg = "transparent",
    height=480,
    width=480)

##------------------------------------------------------
## build histogram as specified in assignment for Plot 1
##------------------------------------------------------
hist(data$Global_active_power,
     freq=TRUE,
     col="RED",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

## close graphics device
dev.off()
