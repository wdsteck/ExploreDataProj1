#
# plot1.R script
#
# This script reads electrical usage data of a sample home and creates
# some plots from that data usimg the base plotting system.
#
# The data is located at: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# This script creates the first plot. It is found in the class
# repo here: https://github.com/rdpeng/ExData_Plotting1
#
# The plot is a histogram of the frequency of the Global Active Power reading
# over a 2 day period (2007-02-01 and 2007-02-02).
# 
# This script reads the raw data, extracts the information for the dates
# requested and creates the plot.
#

setwd("/Users/bill/Desktop/class/exploratory data/proj1")
require(lubridate)

# Download the data file and extract it from the zip if the data file is not local

dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFileZip <- "data.zip"
dataFileSrc <- "household_power_consumption.txt"
dataFileOut <- "plot1.png"

if (!file.exists(dataFileSrc)) {
        if (!file.exists(dataFileZip)) {
                if (download.file(dataFileURL, dataFileZip)) {
                        stop(paste("Could not download data file <", dataFileURL,
                                   "> to zip file <", dataFileZip, ">", sep = ""))
                }
        }
        unzip(dataFileZip)
        if (!file.exists(dataFileSrc)) {
                stop(paste("Could not unzip data zip file <", dataFileZip,
                     "> to data file <", dataFileSrc, ">", sep = ""))
        }
}

 # Extract the data from the data file.
df <- read.table(dataFileSrc, header = TRUE, sep = ";", na.strings = c("?"))

# convert the date to a date structure
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# extract only the dates we care about
df <- with(df, df[(Date >= "2007-02-01") & (Date <= "2007-02-02"), ])

# Create the Global Active Power histogram Chart

# first open the png device.
png(dataFileOut, width = 480, height = 480)

# create the histogram

hist(df$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red"
     )

# Close teh device
dev.off()
