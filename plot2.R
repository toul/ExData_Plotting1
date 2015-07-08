# Generate plot2.png using the base plotting system

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

# Plot 2
# Set graphics device parameters, initialize margins, rows and columns 
png("plot2.png", width=480, height=480)
par(mar = c(4,4,1,1))
par(mfrow = c(1, 1))
# Draw graph then close the graphics device
plot(PData$datetime,PData$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     xlab ="", type = "n")
lines(PData$datetime,PData$Global_active_power, type = "l")
dev.off()