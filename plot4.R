# Generate plot4.png using the base plotting system

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


# Plot 4
# Set graphics device parameters, initialize margins, rows and columns 
png("plot4.png", width=480, height=480)
par(mar = c(4,4,4,1))
par(mfrow = c(2, 2))

with (PData, {
    # Draw each graph in the order one at a time
    # Row 1, column 1
    plot(datetime,Global_active_power, ylab = "Global Active Power",xlab ="", type = "n")
    lines(datetime,Global_active_power, type = "l")
    # Row 1, column 2
    plot(datetime,Voltage, ylab = "Voltage", xlab ="datetime", type = "n")
    lines(datetime,Voltage, type = "l")
    # Row 2, column 1
    plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", main = "", type = "n")
    lines(datetime, Sub_metering_1, col = "black", type = "l", lwd = 1)
    lines(datetime, Sub_metering_2, col = "red", type = "l", lwd = 1)
    lines(datetime, Sub_metering_3, col = "blue", type = "l", lwd = 1)
    # Draw the legend with line type 1 for symbols and without a border
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c("black", "red", "blue"),lty=c(1,1,1), bty = "n", lwd = 1)
    # Row 2, column 2
    plot(datetime,Global_reactive_power, xlab ="datetime", type = "n")
    lines(datetime,Global_reactive_power, type = "l")
})
dev.off()