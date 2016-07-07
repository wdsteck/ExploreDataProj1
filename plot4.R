#
# plot4.R script
#
# This script reads electrical usage data of a sample home and creates
# some plots from that data using the base plotting system.
#
# The data is located at: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# This script creates the fourth plot. It is found in the class
# repo here: https://github.com/rdpeng/ExData_Plotting1
#
# The plot has 4 graphs on it (2x2). Each data platted as a function of time
# over a 2 day period (2007-02-01 and 2007-02-02).
# - The first plots the Global Active Power (same as what plot2.R produces)
# - The next plots the voltage.
# - The next plots the sub metering power (same as what plot3.R produces)
# - The last plots the global reactive power.
# 
# This script reads the raw data, extracts the information for the dates
# requested and creates the plot.
#

# Download the data file and extract it from the zip if the data file is not local

dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataFileZip <- "data.zip"
dataFileSrc <- "household_power_consumption.txt"
dataFileOut <- "plot4.png"

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
df <- read.table(dataFileSrc,
                 header = TRUE,
                 sep = ";",
                 na.strings = c("?"),
                 stringsAsFactors = FALSE
                 )

# convert the date to a date structure
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# extract only the dates we care about
df <- with(df, df[(Date >= "2007-02-01") & (Date <= "2007-02-02"), ])

# add new col for time/date field
df$TimeDate <- as.POSIXct(strptime(paste(df$Date, df$Time), "%Y-%m-%d %H:%M:%S"))

# Create the chart

# first open the png device.
png(dataFileOut, width = 480, height = 480)

# Set up the plot area
par(mfrow=c(2,2))

# Plot the 1st chart

plot(df$TimeDate, df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)

# Plot the 2nd chart

plot(df$TimeDate, df$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage"
)

# Plot the 3rd chart
plot(range(df$TimeDate), range(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3),
     type = "n",
     xlab = "",
     ylab = "Energy Sub Metering"
     )
lines(df$TimeDate,df$Sub_metering_1, type = "l", col = "black")
lines(df$TimeDate,df$Sub_metering_2, type = "l", col = "red")
lines(df$TimeDate,df$Sub_metering_3, type = "l", col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       cex = .8,
       lty = 1
       )

# Plot the 4th chart

plot(df$TimeDate, df$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power"
)

# Close the device
dev.off()
