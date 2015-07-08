# Generate plot3.png using the base plotting system

# Assign 'datapath' to location of the data file (edit as required)
datapath <- "../../"

# Define column classes and read the data, excluding "?", "NA" and empty values
classes <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
PData <- read.csv(paste(datapath,"household_power_consumption.txt", sep = ""),sep = ";",
      colClasses = classes, na.strings = c("?", "NA", ""))

# The 'Date' column is in character format and dates are in the form 'dd/mm/yyyy'
# Subset '1/2/2007' and '2/2/2007' dates only (Thursday and Friday)
PData <- subset(PData, (PData$Date == "1/2/2007") | (PData$Date == "2/2/2007"))

# Create 'datetime' as a POSIXlt vector then bind it to PData for graphing below
datetime <-  strptime(paste(PData$Date,PData$Time),"%d/%m/%Y %H:%M:%S")
PData <- cbind(PData,datetime)

# Plot 3
# Set graphics device parameters, initialize margins, rows and columns 
png("plot3.png", width=480, height=480)
par(mar = c(4,4,1,1))
par(mfrow = c(1, 1))

with(PData, {
    # First, draw the x and y axes and labels, without data points
    plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", main = "", type = "n")
    # Next, draw each sub meter data one at a time in different colours
    lines(datetime, Sub_metering_1, col = "black", type = "l", lwd = 1)
    lines(datetime, Sub_metering_2, col = "red", type = "l", lwd = 1)
    lines(datetime, Sub_metering_3, col = "blue", type = "l", lwd = 1)
    # Draw the legend with line type 1 for symbols
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),lty=c(1,1,1), lwd = 1)
})
dev.off()